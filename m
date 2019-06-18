Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D63C31E51
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D7F420863
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729168AbfFRIgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:36:47 -0400
Received: from mail1.bemta24.messagelabs.com ([67.219.250.2]:50829 "EHLO
        mail1.bemta24.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725913AbfFRIgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:36:46 -0400
Received: from [67.219.251.51] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-5.bemta.az-c.us-west-2.aws.symcld.net id 9B/65-08344-A92A80D5; Tue, 18 Jun 2019 08:36:42 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+JIrShJLcpLzFFi42LxThM+pjtzEUe
  swcuFFhbNi9ezWVzeNYfNYtGyVmYHZo/9c9ewe3zeJBfAFMWamZeUX5HAmtGz+wJbweeIil0z
  P7E1MP4P6GLk4hAS2Mwo8XXrT3YIZxOjxInHa9i6GDmBnIOMEj+umIDYbAKOEl9/PmYHsUUEj
  CX6z84Ca2AWmAnUPWs2WIOwgIPElG1v2CCKHCW+LPzCCGEbSSx6s4kZxGYRUJX40XadBcTmFX
  CXWNX/DqieA2hZtsT++1IgYU4BfYlX7z6AlTMKiEl8P7WGCcRmFhCXuPVkPpgtISAi8fDiaTY
  IW1Ti5eN/rBC2gcTWpftYQEZKCChI/H/BAdGaJnHz3CqorYISJ2c+YYF4UVfi8vx/7BMYxWYh
  2TALScssJC0QcR2JBbs/sUHY2hLLFr5mhrDzJf4c3wlVEyLxduNDoDgohG4zSkzcdoQdIqEoM
  aX7IfsCRs5VjOZJRZnpGSW5iZk5uoYGBrqGhka6hsbmuubGeolVusl6pcW65anFJbpGeonlxX
  rFlbnJOSl6eaklmxiBsZ9S0Om5g3HGkdd6hxglOZiURHmTotljhfiS8lMqMxKLM+KLSnNSiw8
  xynBwKEnwmgCTiZBgUWp6akVaZg4wDcGkJTh4lER48xcCpXmLCxJzizPTIVKnGO05Jrycu4iZ
  4+DReUBy1X8Q+XvDkkXMQix5+XmpUuK80SBtAiBtGaV5cENhafMSo6yUMC8jAwODEE9BalFuZ
  gmq/CtGcQ5GJWHeP/OBpvBk5pXA7X4FdBYT0FmPlrKBnFWSiJCSamBquev3SvLRep7365gFXi
  XIHrhysiJ5tVGd0LcNWs9PV7RFrQp+vcpt9pOpu6LUGtgVtXNVJmheaw88zH2yzyhCUnLOlsM
  azVWKiXLN9mvi4303WiutPag1de3qzP0aFWYLeip8k1blZNs4ij6J5JGcJFBdvfvGngYRn7sC
  gccUWR4sqDR74Gk1N36GnfeBc+12IR8WRx4+c2jzoRdZq5+J1H+s5riiP2tzxLbl27cVl/J0X
  5d6ITiztOqsY8fTQJ+mf0/sLn05Xvew7ruci+bK7H3cK6PiTzXvf/Nxn/K3mW2CkcedPtxRX3
  PWZm2zzEGXg6da3756M/0FT6zeFFn7gyUPV3hvfZ3+JiFH6fxTJZbijERDLeai4kQAqLmXERY
  EAAA=
X-Env-Sender: Kiruthika.Varadarajan@harman.com
X-Msg-Ref: server-13.tower-363.messagelabs.com!1560847001!10057753!1
X-Originating-IP: [75.102.19.198]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 1691 invoked from network); 18 Jun 2019 08:36:41 -0000
Received: from unknown.ord.scnet.net (HELO HICGWSMB09.ad.harman.com) (75.102.19.198)
  by server-13.tower-363.messagelabs.com with DHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 18 Jun 2019 08:36:41 -0000
Received: from HICGWSMB02.ad.harman.com (10.10.24.95) by
 HICGWSMB09.ad.harman.com (10.10.24.241) with Microsoft SMTP Server (TLS) id
 15.0.1365.1; Tue, 18 Jun 2019 04:36:40 -0400
Received: from HICGWSMB01.ad.harman.com (10.10.24.94) by
 HICGWSMB02.ad.harman.com (10.10.24.95) with Microsoft SMTP Server (TLS) id
 15.0.1365.1; Tue, 18 Jun 2019 04:36:40 -0400
Received: from HICGWSMB01.ad.harman.com ([fe80::941a:f5b7:534a:7737]) by
 HICGWSMB01.ad.harman.com ([fe80::941a:f5b7:534a:7737%13]) with mapi id
 15.00.1365.000; Tue, 18 Jun 2019 03:36:40 -0500
From:   "Varadarajan, Kiruthika" <Kiruthika.Varadarajan@harman.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Felipe Balbi <balbi@ti.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: Kernel patch  in USB 4.4.138 Version
Thread-Topic: [EXTERNAL] Re: Kernel patch  in USB 4.4.138 Version
Thread-Index: AQHVHTkp8UnjGujKFk+69XE7CW1vK6ahJuHQ
Date:   Tue, 18 Jun 2019 08:36:40 +0000
Message-ID: <f23db47458494f58abbc7669118d0dbb@HICGWSMB01.ad.harman.com>
References: <6e521b173bd24197930c764dc5fe9ad1@HICGWSMB01.ad.harman.com>
 <20190607135853.GB14665@kroah.com>
In-Reply-To: <20190607135853.GB14665@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.10.24.164]
Content-Type: multipart/mixed;
        boundary="_002_f23db47458494f58abbc7669118d0dbbHICGWSMB01adharmancom_"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--_002_f23db47458494f58abbc7669118d0dbbHICGWSMB01adharmancom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

 Hi Greg,
 I applied the attached patch against 4.4.x kernel version. Could you pleas=
e review the patch.


Thanks and Regards,
Kiruthika. NV

-----Original Message-----
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>=20
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
> 4.4.71-quilt-2e5dc0ac-g0b463804d692-dirty #45 [ 64.814092] Workqueue:=20
> uether process_rx_w [ 64.818675] task: ffff8800779c40c0 ti:=20
> ffff88007702c000 task.ti: ffff88007702c000 [ 64.827040] RIP:=20
> 0010:[<ffffffff81736b6d>] [<ffffffff81736b6d>] rx_fill+0x1ed/0x3b0 [=20
> 64.835706] RSP: 0000:ffff88007702fd80 EFLAGS: 00010246 [ 64.841642]=20
> RAX: 0000000000000000 RBX: ffff88006f2768c0 RCX: 0000000000000200 [=20
> 64.849617] RDX: 00000000000001fd RSI: ffffffff82081f71 RDI:=20
> 00000000ffffffff [ 64.857591] RBP: ffff88007702fdc8 R08:=20
> ffffc90000285000 R09: 0000000000000600 [ 64.865566] R10:=20
> ffff88002ab99670 R11: 0000000000000f7a R12: 0000000000000002 [=20
> 64.873541] R13: ffff88006f2768f0 R14: 0000000000000600 R15:=20
> ffff88006bf6f118 [ 64.881509] FS: 0000000000000000(0000)=20
> GS:ffff88007ac00000(0000) knlGS:0000000000000000 [ 64.890545] CS: 0010 DS=
: 0000 ES: 0000 CR0: 0000000080050033 [ 64.896965] CR2: 00000000000000f0 CR=
3: 0000000065c99000 CR4: 00000000003406f0 [ 64.904936] Last Branch Records:
> [ 64.908551] to: [<ffffffff81a50260>] page_fault+0x0/0x80 [ 64.914787]=20
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
> [<ffffffff81a47a33>] preempt_schedule_common+0x33/0x40 [ 65.039835]=20
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
> [ 65.232171] from: [<ffffffff813deb26>]=20
> check_preemption_disabled+0x26/0xf0
> [ 65.239952] to: [<ffffffff813deb00>]=20
> check_preemption_disabled+0x0/0xf0
> [ 65.247632] from: [<ffffffff813dec02>]=20
> debug_smp_processor_id+0x12/0x20 [ 65.255124] to: [<ffffffff813debf0>]=20
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
> [ 65.351585] 0000000000000286 ffff88006bd22548 024000c081a4dae8=20
> ffff88006f276918 [ 65.359856] 0000000000000000 0000000000000000=20
> ffff88006f276938 ffff88006f2768c0 [ 65.368143] ffff88006f2769a8=20
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
> [ 65.437077] Code: 4c 89 c9 41 83 e9 01 4d 63 c9 4d 01 f1 4c 89 c8 48=20
> f7 f1 8b 83 b0 00 00 00 49 29 d1 4d 89 ce 85 c0 74 04 4c 0f af f0 48=20
> 8b 43 18 <80> b8 f0 00 00 00 00 0f 85 78 01 00 00 48 8b 73 20 4c 89 f1=20
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

--_002_f23db47458494f58abbc7669118d0dbbHICGWSMB01adharmancom_
Content-Type: application/octet-stream;
	name="0001-PATCH-USB-Fix-race-between-gether_disconnect-and-rx_.patch"
Content-Description: 0001-PATCH-USB-Fix-race-between-gether_disconnect-and-rx_.patch
Content-Disposition: attachment;
	filename="0001-PATCH-USB-Fix-race-between-gether_disconnect-and-rx_.patch";
	size=1584; creation-date="Tue, 18 Jun 2019 08:34:27 GMT";
	modification-date="Tue, 18 Jun 2019 08:34:27 GMT"
Content-Transfer-Encoding: base64

RnJvbSAwZTBjNmY2M2UyYjNiNGZlMjlmODNkNDg1N2ExNGRhODU1MzQyYWZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBrdmFyYWRhcmFqYW4gPEtpcnV0aGlrYS5WYXJhZGFyYWphbkBo
YXJtYW4uY29tPgpEYXRlOiBUdWUsIDE4IEp1biAyMDE5IDA4OjMwOjMxICswMDAwClN1YmplY3Q6
IFtQQVRDSF0gW1BBVENIXSBVU0I6IEZpeCByYWNlIGJldHdlZW4gZ2V0aGVyX2Rpc2Nvbm5lY3Qg
YW5kIHJ4X3N1Ym1pdAoKICBPbiBzcGluIGxvY2sgcmVsZWFzZSBpbiByeF9zdWJtaXQsIGdldGhl
cl9kaXNjb25uZWN0IGdldAogIGEgY2hhbmNlIHRvIHJ1biwgaXQgbWFrZXMgcG9ydF91c2IgTlVM
TCwgcnhfc3VibWl0IGFjY2VzcwogIE5VTEwgcG9ydCBVU0IsIGhlbmNlIG51bGwgcG9pbnRlciBj
cmFzaC4KCiAgRml4ZWQgYnkgcmVsZWFzaW5nIHRoZSBsb2NrIGluIHJ4X3N1Ym1pdCBhZnRlciBw
b3J0X3VzYgogIGlzIHVzZWQuCgogIFNpZ25lZC1vZmYtYnk6S2lydXRoaWthIFZhcmFkYXJhamFu
PEtpcnV0aGlrYS5WYXJhZGFyYWphbkBoYXJtYW4uY29tPgotLS0KIGRyaXZlcnMvdXNiL2dhZGdl
dC9mdW5jdGlvbi91X2V0aGVyLmMgfCA2ICsrKystLQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9nYWRnZXQv
ZnVuY3Rpb24vdV9ldGhlci5jIGIvZHJpdmVycy91c2IvZ2FkZ2V0L2Z1bmN0aW9uL3VfZXRoZXIu
YwppbmRleCA3MzdiZDc3Li4yOTI5YmI0IDEwMDY0NAotLS0gYS9kcml2ZXJzL3VzYi9nYWRnZXQv
ZnVuY3Rpb24vdV9ldGhlci5jCisrKyBiL2RyaXZlcnMvdXNiL2dhZGdldC9mdW5jdGlvbi91X2V0
aGVyLmMKQEAgLTE4NiwxMSArMTg2LDEyIEBAIHN0YXRpYyB2b2lkIGRlZmVyX2tldmVudChzdHJ1
Y3QgZXRoX2RldiAqZGV2LCBpbnQgZmxhZykKIAkJb3V0ID0gZGV2LT5wb3J0X3VzYi0+b3V0X2Vw
OwogCWVsc2UKIAkJb3V0ID0gTlVMTDsKLQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkZXYtPmxv
Y2ssIGZsYWdzKTsKIAogCWlmICghb3V0KQorCXsKKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgm
ZGV2LT5sb2NrLCBmbGFncyk7CiAJCXJldHVybiAtRU5PVENPTk47Ci0KKwl9CiAKIAkvKiBQYWRk
aW5nIHVwIHRvIFJYX0VYVFJBIGhhbmRsZXMgbWlub3IgZGlzYWdyZWVtZW50cyB3aXRoIGhvc3Qu
CiAJICogTm9ybWFsbHkgd2UgdXNlIHRoZSBVU0IgInRlcm1pbmF0ZSBvbiBzaG9ydCByZWFkIiBj
b252ZW50aW9uOwpAQCAtMjE0LDYgKzIxNSw3IEBAIHN0YXRpYyB2b2lkIGRlZmVyX2tldmVudChz
dHJ1Y3QgZXRoX2RldiAqZGV2LCBpbnQgZmxhZykKIAogCWlmIChkZXYtPnBvcnRfdXNiLT5pc19m
aXhlZCkKIAkJc2l6ZSA9IG1heF90KHNpemVfdCwgc2l6ZSwgZGV2LT5wb3J0X3VzYi0+Zml4ZWRf
b3V0X2xlbik7CisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmZGV2LT5sb2NrLCBmbGFncyk7CiAK
IAlza2IgPSBfX25ldGRldl9hbGxvY19za2IoZGV2LT5uZXQsIHNpemUgKyBORVRfSVBfQUxJR04s
IGdmcF9mbGFncyk7CiAJaWYgKHNrYiA9PSBOVUxMKSB7Ci0tIAoxLjkuMQoK

--_002_f23db47458494f58abbc7669118d0dbbHICGWSMB01adharmancom_--
