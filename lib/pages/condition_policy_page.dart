import 'package:flutter/material.dart';
import 'package:flutter/material.dart';

class ConditionPolicy extends StatefulWidget {
  const ConditionPolicy({super.key});

  @override
  State<ConditionPolicy> createState() => _ConditionPolicyState();
}

class _ConditionPolicyState extends State<ConditionPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text('Syarat & Ketentuan'),
      ),
      body: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  'Syarat dan Ketentuan',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  '     Selamat datang di Platform (sebagaimana didefinisikan di bawah) Flip, terima kasih telah menggunakan maupun mengakses Layanan Flip (sebagaimana didefinisikan di bawah) melalui Platform. Syarat dan ketentuan penggunaan Platform yang tertera pada halaman ini (“Syarat dan Ketentuan”) mengatur akses Anda terhadap Platform Flip dan penggunaan seluruh Fitur (sebagaimana didefinisikan di bawah ini) di dalamnya yang dikembangkan oleh Kami, PT Fliptech Lentera Inspirasi Pertiwi (“Flip” atau “Kami”).',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '     Dengan melakukan akses pada Platform, Anda menyatakan telah membaca, mengerti dan setuju untuk mengikatkan diri pada Syarat dan Ketentuan ini. Jika Anda tidak menyetujui Syarat dan Ketentuan ini, maka Anda tidak diperkenankan untuk mengakses Platform atau menggunakan Fitur. Syarat dan Ketentuan ini dapat dianggap sebagai perjanjian induk yang menjadi acuan untuk mengatur syarat dan ketentuan lainnya termasuk namun tidak terbatas pada kebijakan privasi atau ketentuan lainnya yang dapat dibuat oleh Kami dari waktu ke waktu, dan dengan mengikatkan diri pada Syarat dan Ketentuan ini, maka Anda menyatakan tunduk pada turunan dari Syarat dan Ketentuan ini. Ketidakberlakuan syarat dan ketentuan lainnya tidak akan menyebabkan Syarat dan Ketentuan ini menjadi tidak sah, tidak berlaku, dan/atau tidak dapat dilaksanakan.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
