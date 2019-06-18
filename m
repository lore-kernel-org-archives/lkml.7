Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BFDC31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:44:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AE1206B7
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbfFRIoD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:44:03 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.210]:60469 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726330AbfFRIoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:44:03 -0400
Received: from [67.219.251.50] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-c.us-west-2.aws.symcld.net id 8D/8B-20654-F44A80D5; Tue, 18 Jun 2019 08:43:59 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+JIrShJLcpLzFFi42LxThM+puu/hCP
  W4O5RQYvmxevZLLYfFbC4vGsOm8WiZa3MDiweO2fdZffYP3cNu8fnTXIBzFGsmXlJ+RUJrBmH
  W/6wFCyKqfh66jdrA+PL4C5GLg4hgc2MEpOOH2CCcDYxSpybdh3KOcgo8ejMcyCHk4NNwFHi6
  8/H7CC2iICxRP/ZWewgRcwCpxklWg+1sIAkhAUcJKZse8MGUeQo8WXhF0YI20ri0a6NrCA2i4
  CqRPverWBDeQXcJX4cWQRWLySQI/Gs4znYAkYBMYnvp9aA1TALiEvcejIfzJYQEJF4ePE0G4Q
  tKvHy8T9WCNtAYuvSfUA3cADZChL/X3BAtKZJ7DlzjQ1ilaDEyZlPWCBW6Upcnv+PfQKj6Cwk
  G2YhaZmFpAUiriOxYPcnNghbW2LZwtfMEHaWxJbvW6Fsf4kTH2+xzwIHyzVGiQXbWxghEooSU
  7ofsi9g5FzFaJ5UlJmeUZKbmJmja2hgoGtoaKRraGypa2qhl1ilm6xXWqxbnlpcomukl1herF
  dcmZuck6KXl1qyiREY+SkF3VY7GPsOvNY7xCjJwaQkypsUzR4rxJeUn1KZkVicEV9UmpNafIh
  RhoNDSYK3fDFHrJBgUWp6akVaZg4wCcGkJTh4lER4TywCSvMWFyTmFmemQ6ROMdpzTHg5dxEz
  x8Gj84Dkqv8g8veGJYuYhVjy8vNSpcR5l4G0CYC0ZZTmwQ2FJc1LjLJSwryMDAwMQjwFqUW5m
  SWo8q8YxTkYlYR5/8wHmsKTmVcCt/sV0FlMQGc9WsoGclZJIkJKqoFp36/8yS9CLLWMe+xy3u
  8RKjS48TVh2/8792sc7jTOf1vAafeZxX958YQt8pZmXnnX3iorTFC/VzXv0j37de1TTwSp2lU
  zze42EF+Xs/2rx5ErS71mt37ddvmg83OrTA6N2ys4EhyO1urJaR4PP7bYzETmxOyj9msv7Tse
  wVF1qSyke1tVdIeegdKk2fKPtS2DM1Q3bJW+eGLCL6H8p6e7Dyx9XH1qV+DxD8r1m/b/4TZqb
  K6SnvYm8NG25c//eswsOCi25u+zre2lPKJpckzuZsG2Lnuj7C/0GjS1JZn31XOXz5Z5c7Wt1s
  3qyo70A3FFM9d5ej28+/G1QriC6lPtLK3kY371ovvfSaYF/dJSYinOSDTUYi4qTgQAWAwD+RU
  EAAA=
X-Env-Sender: Kiruthika.Varadarajan@harman.com
X-Msg-Ref: server-18.tower-362.messagelabs.com!1560847437!9717189!1
X-Originating-IP: [75.102.19.198]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5812 invoked from network); 18 Jun 2019 08:43:59 -0000
Received: from unknown.ord.scnet.net (HELO HICGWSMB10.ad.harman.com) (75.102.19.198)
  by server-18.tower-362.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 18 Jun 2019 08:43:59 -0000
Received: from HICGWSMB05.ad.harman.com (10.10.24.98) by
 HICGWSMB10.ad.harman.com (10.10.24.242) with Microsoft SMTP Server (TLS) id
 15.0.1365.1; Tue, 18 Jun 2019 04:43:57 -0400
Received: from HICGWSMB01.ad.harman.com (10.10.24.94) by
 HICGWSMB05.ad.harman.com (10.10.24.98) with Microsoft SMTP Server (TLS) id
 15.0.1365.1; Tue, 18 Jun 2019 04:43:56 -0400
Received: from HICGWSMB01.ad.harman.com ([fe80::941a:f5b7:534a:7737]) by
 HICGWSMB01.ad.harman.com ([fe80::941a:f5b7:534a:7737%13]) with mapi id
 15.00.1365.000; Tue, 18 Jun 2019 03:43:56 -0500
From:   "Varadarajan, Kiruthika" <Kiruthika.Varadarajan@harman.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kiruthikanv@gmail.com" <kiruthikanv@gmail.com>
Subject: RE: [EXTERNAL] Re: Kernel patch  in USB 4.4.138 Version
Thread-Topic: [EXTERNAL] Re: Kernel patch  in USB 4.4.138 Version
Thread-Index: AQHVHTkp8UnjGujKFk+69XE7CW1vK6ahJuHQgAACNTA=
Date:   Tue, 18 Jun 2019 08:43:56 +0000
Message-ID: <61ab2bb8e87e4c6a967722a4ae757a4a@HICGWSMB01.ad.harman.com>
References: <6e521b173bd24197930c764dc5fe9ad1@HICGWSMB01.ad.harman.com>
 <20190607135853.GB14665@kroah.com> 
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.10.24.164]
Content-Type: multipart/mixed;
        boundary="_002_61ab2bb8e87e4c6a967722a4ae757a4aHICGWSMB01adharmancom_"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_61ab2bb8e87e4c6a967722a4ae757a4aHICGWSMB01adharmancom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Greg,
 Please ignore my previous email and here is the patch on top of 4.4.x stab=
le version.
 Could you please review the attached patch.

Thanks and Regards,
Kiruthika. NV

-----Original Message-----
From: Varadarajan, Kiruthika=20
Sent: Tuesday, June 18, 2019 2:07 PM
To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
Cc: Felipe Balbi <balbi@ti.com>; linux-usb@vger.kernel.org; linux-kernel@vg=
er.kernel.org
Subject: RE: [EXTERNAL] Re: Kernel patch in USB 4.4.138 Version

 Hi Greg,
 I applied the attached patch against 4.4.x kernel version. Could you pleas=
e review the patch.


Thanks and Regards,
Kiruthika. NV

-----Original Message-----
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Sent: Friday, June 7, 2019 7:29 PM
To: Varadarajan, Kiruthika <Kiruthika.Varadarajan@harman.com>
Cc: Felipe Balbi <balbi@ti.com>; linux-usb@vger.kernel.org; linux-kernel@vg=
er.kernel.org
Subject: [EXTERNAL] Re: Kernel patch in USB 4.4.138 Version

On Fri, Jun 07, 2019 at 08:23:37AM +0000, Varadarajan, Kiruthika wrote:
> Hi All,
>   During Cay Play session connect/disconnect several times,  with USB gad=
get driver I found kernel crash in rx_submit.
>=20
>=20
> 64.802125] CPU: 0 PID: 636 Comm: kworker/u8:2 Tainted: G U W O=20
> 4.4.71-quilt-2e5dc0ac-g0b463804d692-dirty #45 [ 64.814092] Workqueue:
> uether process_rx_w [ 64.818675] task: ffff8800779c40c0 ti:=20
> ffff88007702c000 task.ti: ffff88007702c000 [ 64.827040] RIP:=20
> 0010:[<ffffffff81736b6d>] [<ffffffff81736b6d>] rx_fill+0x1ed/0x3b0 [=20
> 64.835706] RSP: 0000:ffff88007702fd80 EFLAGS: 00010246 [ 64.841642]
> RAX: 0000000000000000 RBX: ffff88006f2768c0 RCX: 0000000000000200 [=20
> 64.849617] RDX: 00000000000001fd RSI: ffffffff82081f71 RDI:
> 00000000ffffffff [ 64.857591] RBP: ffff88007702fdc8 R08:=20
> ffffc90000285000 R09: 0000000000000600 [ 64.865566] R10:=20
> ffff88002ab99670 R11: 0000000000000f7a R12: 0000000000000002 [=20
> 64.873541] R13: ffff88006f2768f0 R14: 0000000000000600 R15:
> ffff88006bf6f118 [ 64.881509] FS: 0000000000000000(0000)
> GS:ffff88007ac00000(0000) knlGS:0000000000000000 [ 64.890545] CS: 0010 DS=
: 0000 ES: 0000 CR0: 0000000080050033 [ 64.896965] CR2: 00000000000000f0 CR=
3: 0000000065c99000 CR4: 00000000003406f0 [ 64.904936] Last Branch Records:
> [ 64.908551] to: [<ffffffff81a50260>] page_fault+0x0/0x80 [ 64.914787]
> from: [<ffffffff81736b6d>] rx_fill+0x1ed/0x3b0 [ 64.921020] to:=20
> [<ffffffff81736b69>] rx_fill+0x1e9/0x3b0 [ 64.927253] from:=20
> [<ffffffff81736b63>] rx_fill+0x1e3/0x3b0 [ 64.933480] to:=20
> [<ffffffff81736b37>] rx_fill+0x1b7/0x3b0 [ 64.939704] from:=20
> [<ffffffff811804bd>] printk+0x4f/0x50 [ 64.945654] to:=20
> [<ffffffff811804b6>] printk+0x48/0x50 [ 64.951588] from:=20
> [<ffffffff810ecb60>] vprintk_default+0x20/0x30 [ 64.958403] to:=20
> [<ffffffff810ecb5f>] vprintk_default+0x1f/0x30 [ 64.965219] from:=20
> [<ffffffff810ec64f>] vprintk_emit+0x16f/0x530 [ 64.971941] to:=20
> [<ffffffff810ec641>] vprintk_emit+0x161/0x530 [ 64.978653] from:=20
> [<ffffffff810ec752>] vprintk_emit+0x272/0x530 [ 64.985383] to:=20
> [<ffffffff810ec752>] vprintk_emit+0x272/0x530 [ 64.992116] from:=20
> [<ffffffff81001387>] restore+0xd/0x16 [ 64.998059] to:=20
> [<ffffffff8100137a>] restore+0x0/0x16 [ 65.003999] from:=20
> [<ffffffff81001364>] ___preempt_schedule+0x12/0x14 [ 65.011205] to:=20
> [<ffffffff81001364>] ___preempt_schedule+0x12/0x14 [ 65.018411] from:=20
> [<ffffffff81a47a60>] preempt_schedule+0x20/0x30 [ 65.025324] to:=20
> [<ffffffff81a47a5f>] preempt_schedule+0x1f/0x30 [ 65.032228] from:=20
> [<ffffffff81a47a33>] preempt_schedule_common+0x33/0x40 [ 65.039835]
> to: [<ffffffff81a47a1f>] preempt_schedule_common+0x1f/0x40 [=20
> 65.047427] from: [<ffffffff81a471db>] __schedule+0x36b/0xb90 [=20
> 65.053952] to: [<ffffffff81a471bc>] __schedule+0x34c/0xb90 [=20
> 65.060478] from: [<ffffffff810c1326>] finish_task_switch+0xb6/0x210 [=20
> 65.067688] to: [<ffffffff810c12fb>] finish_task_switch+0x8b/0x210 [=20
> 65.074886] from: [<ffffffff81a4db3a>] _raw_spin_unlock_irq+0x2a/0x40 [=20
> 65.082190] to: [<ffffffff81a4db2e>] _raw_spin_unlock_irq+0x1e/0x40 [=20
> 65.089494] from: [<ffffffff810bde65>] preempt_count_sub+0x35/0xb0 [=20
> 65.096508] to: [<ffffffff810bde5b>] preempt_count_sub+0x2b/0xb0 [=20
> 65.103511] from: [<ffffffff810bdea5>] preempt_count_sub+0x75/0xb0 [=20
> 65.110517] to: [<ffffffff810bde9c>] preempt_count_sub+0x6c/0xb0 [=20
> 65.117522] from: [<ffffffff810bde59>] preempt_count_sub+0x29/0xb0 [=20
> 65.124530] to: [<ffffffff810bde30>] preempt_count_sub+0x0/0xb0 [=20
> 65.131444] from: [<ffffffff81a4db29>] _raw_spin_unlock_irq+0x19/0x40 [=20
> 65.138748] to: [<ffffffff81a4db23>] _raw_spin_unlock_irq+0x13/0x40 [=20
> 65.146052] from: [<ffffffff81155389>] trace_hardirqs_on+0x9/0xf0 [=20
> 65.152958] to: [<ffffffff81155380>] trace_hardirqs_on+0x0/0xf0 [=20
> 65.159872] from: [<ffffffff81a4db1e>] _raw_spin_unlock_irq+0xe/0x40 [=20
> 65.167065] to: [<ffffffff81a4db1e>] _raw_spin_unlock_irq+0xe/0x40 [=20
> 65.174257] from: [<ffffffff810e58cb>] do_raw_spin_unlock+0x4b/0xa0 [=20
> 65.181364] to: [<ffffffff810e5880>] do_raw_spin_unlock+0x0/0xa0 [=20
> 65.188372] from: [<ffffffff81a4db19>] _raw_spin_unlock_irq+0x9/0x40 [=20
> 65.195575] to: [<ffffffff81a4db10>] _raw_spin_unlock_irq+0x0/0x40 [=20
> 65.202776] from: [<ffffffff810c12f6>] finish_task_switch+0x86/0x210 [=20
> 65.209980] to: [<ffffffff810c1295>] finish_task_switch+0x25/0x210 [=20
> 65.217183] from: [<ffffffff813dec08>] debug_smp_processor_id+0x18/0x20=20
> [ 65.224676] to: [<ffffffff813dec07>] debug_smp_processor_id+0x17/0x20=20
> [ 65.232171] from: [<ffffffff813deb26>]
> check_preemption_disabled+0x26/0xf0
> [ 65.239952] to: [<ffffffff813deb00>]
> check_preemption_disabled+0x0/0xf0
> [ 65.247632] from: [<ffffffff813dec02>]
> debug_smp_processor_id+0x12/0x20 [ 65.255124] to: [<ffffffff813debf0>]
> debug_smp_processor_id+0x0/0x20 [ 65.262521] from:=20
> [<ffffffff810c1290>] finish_task_switch+0x20/0x210 [ 65.269734] to:=20
> [<ffffffff810c1270>] finish_task_switch+0x0/0x210 [ 65.276831] from:=20
> [<ffffffff81a471b7>] __schedule+0x347/0xb90 [ 65.283353] to:=20
> [<ffffffff81a47184>] __schedule+0x314/0xb90 [ 65.289871] from:=20
> [<ffffffff81003677>] __switch_to+0x297/0x5a0 [ 65.296486] to:=20
> [<ffffffff81003666>] __switch_to+0x286/0x5a0 [ 65.303092] from:=20
> [<ffffffff81003654>] __switch_to+0x274/0x5a0 [ 65.309728] to:=20
> [<ffffffff81003610>] __switch_to+0x230/0x5a0 [ 65.316352] from:=20
> [<ffffffff81003600>] __switch_to+0x220/0x5a0 [ 65.322972] to:=20
> [<ffffffff810035d3>] __switch_to+0x1f3/0x5a0 [ 65.329582] from:=20
> [<ffffffff810035c3>] __switch_to+0x1e3/0x5a0 [ 65.336203] to:=20
> [<ffffffff81003525>] __switch_to+0x145/0x5a0 [ 65.342821] from:=20
> [<ffffffff810034ce>] __switch_to+0xee/0x5a0 [ 65.349343] Stack:
> [ 65.351585] 0000000000000286 ffff88006bd22548 024000c081a4dae8
> ffff88006f276918 [ 65.359856] 0000000000000000 0000000000000000
> ffff88006f276938 ffff88006f2768c0 [ 65.368143] ffff88006f2769a8
> ffff88007702fe00 ffffffff81736f5f ffff88006f2769a8 [ 65.376447] Call Trac=
e:
> [ 65.379176] [<ffffffff81736f5f>] process_rx_w+0xcf/0x130 [ 65.385213]=20
> [<ffffffff810b29aa>] process_one_work+0x14a/0x450 [ 65.391736]=20
> [<ffffffff810b2fe6>] worker_thread+0x66/0x450 [ 65.397868]=20
> [<ffffffff810b2f80>] ? rescuer_thread+0x2d0/0x2d0 [ 65.404391]=20
> [<ffffffff810b2f80>] ? rescuer_thread+0x2d0/0x2d0 [ 65.410911]=20
> [<ffffffff810b80ad>] kthread+0xfd/0x120 [ 65.416456]=20
> [<ffffffff810b7fb0>] ? kthread_create_on_node+0x190/0x190
> [ 65.423755] [<ffffffff81a4e46f>] ret_from_fork+0x3f/0x70 [ 65.429785]=20
> [<ffffffff810b7fb0>] ? kthread_create_on_node+0x190/0x190
> [ 65.437077] Code: 4c 89 c9 41 83 e9 01 4d 63 c9 4d 01 f1 4c 89 c8 48
> f7 f1 8b 83 b0 00 00 00 49 29 d1 4d 89 ce 85 c0 74 04 4c 0f af f0 48=20
> 8b 43 18 <80> b8 f0 00 00 00 00 0f 85 78 01 00 00 48 8b 73 20 4c 89 f1
> 48 [ 65.458462] RIP [<ffffffff81736b6d>] rx_fill+0x1ed/0x3b0 [=20
> 65.464493] RSP <ffff88007702fd80> [ 65.468388] CR2: 00000000000000f0 [=20
> 65.472090] ---[ end trace 5a9d1e73247ee2aa ]--- [ 65.479952] Kernel=20
> panic - not syncing: Fatal exception [ 65.486167] intel_tasks_dumper: int=
el_task_panic_hndl: Skip tasks dumper.
> [ 65.493763] reboot: panic mode set: p,w [ 65.498045] Kernel Offset:=20
> disabled [ 65.509960] Rebooting in 10 seconds..
>=20
>=20
>   I have a patch and I would like to mainline the same patch.
>   Could you please review the same and provide your comments.

Please submit this in a format that we can apply it in.  We can't apply pat=
chs directly to the 4.4.y tree, they have to be backports from Linus's tree=
 only (read the stable kernel rules for details.)

Also, your patch referenced a git commit id that is not in Linus's tree, an=
d you do not need the Change-Id: line as well.

Please fix that up, and redo it against linux-next and resend and we will b=
e glad to review it.

thanks,

greg k-h

--_002_61ab2bb8e87e4c6a967722a4ae757a4aHICGWSMB01adharmancom_
Content-Type: application/octet-stream;
	name="USB-Fix-race-between-gether_disconnect-and-rx_submit.patch"
Content-Description: USB-Fix-race-between-gether_disconnect-and-rx_submit.patch
Content-Disposition: attachment;
	filename="USB-Fix-race-between-gether_disconnect-and-rx_submit.patch";
	size=1591; creation-date="Tue, 18 Jun 2019 08:42:27 GMT";
	modification-date="Tue, 18 Jun 2019 08:42:27 GMT"
Content-Transfer-Encoding: base64

RnJvbSBiNDU1OTVjNDJiNzU4NDViYWM1NGUxMWIzMmQ5M2YzOTZiOGMwNzQ1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBrdmFyYWRhcmFqYW4gPEtpcnV0aGlrYS5WYXJhZGFyYWphbkBo
YXJtYW4uY29tPgpEYXRlOiBUdWUsIDE4IEp1biAyMDE5IDA4OjM5OjA2ICswMDAwClN1YmplY3Q6
IFtQQVRDSF0gIFVTQjogRml4IHJhY2UgYmV0d2VlbiBnZXRoZXJfZGlzY29ubmVjdCBhbmQgcnhf
c3VibWl0CgogIE9uIHNwaW4gbG9jayByZWxlYXNlIGluIHJ4X3N1Ym1pdCwgZ2V0aGVyX2Rpc2Nv
bm5lY3QgZ2V0CiAgYSBjaGFuY2UgdG8gcnVuLCBpdCBtYWtlcyBwb3J0X3VzYiBOVUxMLCByeF9z
dWJtaXQgYWNjZXNzCiAgTlVMTCBwb3J0IFVTQiwgaGVuY2UgbnVsbCBwb2ludGVyIGNyYXNoLgog
IEZpeGVkIGJ5IHJlbGVhc2luZyB0aGUgbG9jayBpbiByeF9zdWJtaXQgYWZ0ZXIgcG9ydF91c2IK
ICBpcyB1c2VkLgoKICBTaWduZWQtb2ZmLWJ5OktpcnV0aGlrYSBWYXJhZGFyYWphbjxLaXJ1dGhp
a2EuVmFyYWRhcmFqYW5AaGFybWFuLmNvbT4KLS0tCiBkcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rp
b24vdV9ldGhlci5jIHwgNiArKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyks
IDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9u
L3VfZXRoZXIuYyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X2V0aGVyLmMKaW5kZXgg
NzQxM2Y4OS4uZTY5ZjIwYiAxMDA2NDQKLS0tIGEvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9u
L3VfZXRoZXIuYworKysgYi9kcml2ZXJzL3VzYi9nYWRnZXQvZnVuY3Rpb24vdV9ldGhlci5jCkBA
IC0yMDcsMTEgKzIwNywxMiBAQCByeF9zdWJtaXQoc3RydWN0IGV0aF9kZXYgKmRldiwgc3RydWN0
IHVzYl9yZXF1ZXN0ICpyZXEsIGdmcF90IGdmcF9mbGFncykKIAkJb3V0ID0gZGV2LT5wb3J0X3Vz
Yi0+b3V0X2VwOwogCWVsc2UKIAkJb3V0ID0gTlVMTDsKLQlzcGluX3VubG9ja19pcnFyZXN0b3Jl
KCZkZXYtPmxvY2ssIGZsYWdzKTsKIAogCWlmICghb3V0KQorCXsKKwkJc3Bpbl91bmxvY2tfaXJx
cmVzdG9yZSgmZGV2LT5sb2NrLCBmbGFncyk7CiAJCXJldHVybiAtRU5PVENPTk47Ci0KKwl9CiAK
IAkvKiBQYWRkaW5nIHVwIHRvIFJYX0VYVFJBIGhhbmRsZXMgbWlub3IgZGlzYWdyZWVtZW50cyB3
aXRoIGhvc3QuCiAJICogTm9ybWFsbHkgd2UgdXNlIHRoZSBVU0IgInRlcm1pbmF0ZSBvbiBzaG9y
dCByZWFkIiBjb252ZW50aW9uOwpAQCAtMjMyLDYgKzIzMyw3IEBAIHJ4X3N1Ym1pdChzdHJ1Y3Qg
ZXRoX2RldiAqZGV2LCBzdHJ1Y3QgdXNiX3JlcXVlc3QgKnJlcSwgZ2ZwX3QgZ2ZwX2ZsYWdzKQog
CiAJaWYgKGRldi0+cG9ydF91c2ItPmlzX2ZpeGVkKQogCQlzaXplID0gbWF4X3Qoc2l6ZV90LCBz
aXplLCBkZXYtPnBvcnRfdXNiLT5maXhlZF9vdXRfbGVuKTsKKwlzcGluX3VubG9ja19pcnFyZXN0
b3JlKCZkZXYtPmxvY2ssIGZsYWdzKTsKIAogCXNrYiA9IGFsbG9jX3NrYihzaXplICsgTkVUX0lQ
X0FMSUdOLCBnZnBfZmxhZ3MpOwogCWlmIChza2IgPT0gTlVMTCkgewotLSAKMS45LjEKCg==

--_002_61ab2bb8e87e4c6a967722a4ae757a4aHICGWSMB01adharmancom_--
