import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Persona {
  const Persona({
    required this.name,
    required this.lastname,
    required this.cuenta,
  });

  final String name;
  final String lastname;
  final String cuenta;

  String get fullName => '$name $lastname';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF3156D3);

    return MaterialApp(
      title: 'Alumnos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: primaryColor),
        scaffoldBackgroundColor: const Color(0xFFF4F6FA),
        fontFamily: 'Roboto',
      ),
      home: const AlumnosPage(),
    );
  }
}

class AlumnosPage extends StatefulWidget {
  const AlumnosPage({super.key});

  @override
  State<AlumnosPage> createState() => _AlumnosPageState();
}

class _AlumnosPageState extends State<AlumnosPage> {
  final List<Persona> _alumnos = [
    const Persona(name: 'Ana', lastname: 'García López', cuenta: '2024001'),
    const Persona(name: 'Carlos', lastname: 'Hernández Ruiz', cuenta: '2024002'),
    const Persona(name: 'Mariana', lastname: 'Torres Díaz', cuenta: '2024003'),
    const Persona(name: 'Diego', lastname: 'Ramírez Soto', cuenta: '2024004'),
  ];

  Future<void> _agregarAlumno() async {
    final alumno = await showModalBottomSheet<Persona>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _FormularioAlumno(
        cuentaRegistrada: (cuenta) => _alumnos.any(
          (alumno) => alumno.cuenta.toLowerCase() == cuenta.toLowerCase(),
        ),
      ),
    );

    if (alumno != null && mounted) {
      setState(() => _alumnos.add(alumno));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${alumno.fullName} se agregó a la lista')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _Encabezado(totalAlumnos: _alumnos.length),
            Padding(
              padding: const EdgeInsets.fromLTRB(22, 24, 22, 14),
              child: Row(
                children: [
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Lista de alumnos',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF202A3B),
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Alumnos registrados en el sistema',
                          style: TextStyle(
                            fontSize: 13,
                            color: Color(0xFF788397),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 7,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8EDFF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_alumnos.length} ${_alumnos.length == 1 ? 'alumno' : 'alumnos'}',
                      style: const TextStyle(
                        color: Color(0xFF3156D3),
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _alumnos.isEmpty
                  ? const _ListaVacia()
                  : ListView.builder(
                      padding: const EdgeInsets.fromLTRB(22, 0, 22, 100),
                      itemCount: _alumnos.length,
                      itemBuilder: (context, index) {
                        return _AlumnoCard(alumno: _alumnos[index]);
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _agregarAlumno,
        icon: const Icon(Icons.person_add_alt_1_rounded),
        label: const Text(
          'Agregar alumno',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class _Encabezado extends StatelessWidget {
  const _Encabezado({required this.totalAlumnos});

  final int totalAlumnos;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 22, 24, 26),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF3156D3), Color(0xFF5479EA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(
                  Icons.school_rounded,
                  color: Colors.white,
                  size: 25,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'CONTROL ESCOLAR',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1.4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 25),
          const Text(
            'Alumnos registrados',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              height: 1.15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 7),
          Text(
            '$totalAlumnos ${totalAlumnos == 1 ? 'alumno registrado' : 'alumnos registrados'}',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.82),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

class _AlumnoCard extends StatelessWidget {
  const _AlumnoCard({required this.alumno});

  final Persona alumno;

  @override
  Widget build(BuildContext context) {
    final initials = alumno.name.isNotEmpty
        ? alumno.name.substring(0, 1).toUpperCase()
        : '?';

    return Card(
      margin: const EdgeInsets.only(bottom: 11),
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(17),
        side: const BorderSide(color: Color(0xFFE9EDF3)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: const Color(0xFFE8EDFF),
              child: Text(
                initials,
                style: const TextStyle(
                  color: Color(0xFF3156D3),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    alumno.fullName,
                    style: const TextStyle(
                      color: Color(0xFF202A3B),
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Cuenta: ${alumno.cuenta}',
                    style: const TextStyle(
                      color: Color(0xFF788397),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.chevron_right_rounded,
              color: Color(0xFFAAB2C0),
            ),
          ],
        ),
      ),
    );
  }
}

class _ListaVacia extends StatelessWidget {
  const _ListaVacia();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.groups_2_outlined,
              size: 58,
              color: Colors.blueGrey.shade200,
            ),
            const SizedBox(height: 14),
            const Text(
              'Aún no hay alumnos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            const Text(
              'Agrega el primer alumno para comenzar.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xFF788397)),
            ),
          ],
        ),
      ),
    );
  }
}

class _FormularioAlumno extends StatefulWidget {
  const _FormularioAlumno({required this.cuentaRegistrada});

  final bool Function(String cuenta) cuentaRegistrada;

  @override
  State<_FormularioAlumno> createState() => _FormularioAlumnoState();
}

class _FormularioAlumnoState extends State<_FormularioAlumno> {
  final _formKey = GlobalKey<FormState>();
  final _nombreController = TextEditingController();
  final _apellidoController = TextEditingController();
  final _cuentaController = TextEditingController();

  @override
  void dispose() {
    _nombreController.dispose();
    _apellidoController.dispose();
    _cuentaController.dispose();
    super.dispose();
  }

  void _guardar() {
    if (!_formKey.currentState!.validate()) return;

    Navigator.of(context).pop(
      Persona(
        name: _nombreController.text.trim(),
        lastname: _apellidoController.text.trim(),
        cuenta: _cuentaController.text.trim(),
      ),
    );
  }

  String? _validarCuenta(String? value) {
    final cuenta = value?.trim() ?? '';
    if (cuenta.isEmpty) return 'Ingresa el número de cuenta';
    if (widget.cuentaRegistrada(cuenta)) {
      return 'Esta cuenta ya está registrada';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        24,
        10,
        24,
        MediaQuery.viewInsetsOf(context).bottom + 24,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Container(
                  width: 38,
                  height: 4,
                  decoration: BoxDecoration(
                    color: const Color(0xFFD8DDE6),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              const Text(
                'Agregar alumno',
                style: TextStyle(
                  color: Color(0xFF202A3B),
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Completa los datos para registrarlo en la lista.',
                style: TextStyle(color: Color(0xFF788397), fontSize: 14),
              ),
              const SizedBox(height: 22),
              _campo(
                controller: _nombreController,
                label: 'Nombre',
                icon: Icons.person_outline_rounded,
                textInputAction: TextInputAction.next,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Ingresa el nombre'
                    : null,
              ),
              const SizedBox(height: 15),
              _campo(
                controller: _apellidoController,
                label: 'Apellido',
                icon: Icons.badge_outlined,
                textInputAction: TextInputAction.next,
                validator: (value) => value == null || value.trim().isEmpty
                    ? 'Ingresa el apellido'
                    : null,
              ),
              const SizedBox(height: 15),
              _campo(
                controller: _cuentaController,
                label: 'Número de cuenta',
                icon: Icons.numbers_rounded,
                textInputAction: TextInputAction.done,
                validator: _validarCuenta,
                onSubmitted: (_) => _guardar(),
              ),
              const SizedBox(height: 23),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  key: const ValueKey('saveStudentButton'),
                  onPressed: _guardar,
                  icon: const Icon(Icons.check_rounded),
                  label: const Text('Guardar alumno'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _campo({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required TextInputAction textInputAction,
    required String? Function(String?) validator,
    ValueChanged<String>? onSubmitted,
  }) {
    return TextFormField(
      key: ValueKey('student${label.replaceAll(' ', '')}Field'),
      controller: controller,
      textInputAction: textInputAction,
      validator: validator,
      onFieldSubmitted: onSubmitted,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        filled: true,
        fillColor: const Color(0xFFF7F8FB),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE3E7EF)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(color: Color(0xFFE3E7EF)),
        ),
      ),
    );
  }
}
