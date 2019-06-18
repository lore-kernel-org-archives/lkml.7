Return-Path: <SRS0=h0iA=UR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C92BC31E5E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C8C520823
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Jun 2019 08:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729292AbfFRIzz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Jun 2019 04:55:55 -0400
Received: from mga17.intel.com ([192.55.52.151]:54737 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbfFRIzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jun 2019 04:55:55 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2019 01:55:54 -0700
X-ExtLoop1: 1
Received: from pipin.fi.intel.com (HELO pipin) ([10.237.72.175])
  by fmsmga001.fm.intel.com with ESMTP; 18 Jun 2019 01:55:52 -0700
From:   Felipe Balbi <felipe.balbi@linux.intel.com>
To:     "Varadarajan\, Kiruthika" <Kiruthika.Varadarajan@harman.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Felipe Balbi <balbi@ti.com>,
        "linux-usb\@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kiruthikanv\@gmail.com" <kiruthikanv@gmail.com>
Subject: RE: [EXTERNAL] Re: Kernel patch  in USB 4.4.138 Version
In-Reply-To: <61ab2bb8e87e4c6a967722a4ae757a4a@HICGWSMB01.ad.harman.com>
References: <6e521b173bd24197930c764dc5fe9ad1@HICGWSMB01.ad.harman.com> <20190607135853.GB14665@kroah.com> <61ab2bb8e87e4c6a967722a4ae757a4a@HICGWSMB01.ad.harman.com>
Date:   Tue, 18 Jun 2019 11:55:48 +0300
Message-ID: <87r27rff1n.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

"Varadarajan, Kiruthika" <Kiruthika.Varadarajan@harman.com> writes:
> Hi Greg,
>  Please ignore my previous email and here is the patch on top of 4.4.x st=
able version.
>  Could you please review the attached patch.
>
> Thanks and Regards,
> Kiruthika. NV
>
> -----Original Message-----
> From: Varadarajan, Kiruthika=20
> Sent: Tuesday, June 18, 2019 2:07 PM
> To: 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
> Cc: Felipe Balbi <balbi@ti.com>; linux-usb@vger.kernel.org; linux-kernel@=
vger.kernel.org
> Subject: RE: [EXTERNAL] Re: Kernel patch in USB 4.4.138 Version
>
>  Hi Greg,
>  I applied the attached patch against 4.4.x kernel version. Could you ple=
ase review the patch.
>
>
> Thanks and Regards,
> Kiruthika. NV
>
> -----Original Message-----
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Sent: Friday, June 7, 2019 7:29 PM
> To: Varadarajan, Kiruthika <Kiruthika.Varadarajan@harman.com>
> Cc: Felipe Balbi <balbi@ti.com>; linux-usb@vger.kernel.org; linux-kernel@=
vger.kernel.org
> Subject: [EXTERNAL] Re: Kernel patch in USB 4.4.138 Version
>
> On Fri, Jun 07, 2019 at 08:23:37AM +0000, Varadarajan, Kiruthika wrote:
>> Hi All,
>>   During Cay Play session connect/disconnect several times,  with USB ga=
dget driver I found kernel crash in rx_submit.
>>=20
>>=20
>> 64.802125] CPU: 0 PID: 636 Comm: kworker/u8:2 Tainted: G U W O=20
>> 4.4.71-quilt-2e5dc0ac-g0b463804d692-dirty #45 [ 64.814092] Workqueue:
>> uether process_rx_w [ 64.818675] task: ffff8800779c40c0 ti:=20
>> ffff88007702c000 task.ti: ffff88007702c000 [ 64.827040] RIP:=20
>> 0010:[<ffffffff81736b6d>] [<ffffffff81736b6d>] rx_fill+0x1ed/0x3b0 [=20
>> 64.835706] RSP: 0000:ffff88007702fd80 EFLAGS: 00010246 [ 64.841642]
>> RAX: 0000000000000000 RBX: ffff88006f2768c0 RCX: 0000000000000200 [=20
>> 64.849617] RDX: 00000000000001fd RSI: ffffffff82081f71 RDI:
>> 00000000ffffffff [ 64.857591] RBP: ffff88007702fdc8 R08:=20
>> ffffc90000285000 R09: 0000000000000600 [ 64.865566] R10:=20
>> ffff88002ab99670 R11: 0000000000000f7a R12: 0000000000000002 [=20
>> 64.873541] R13: ffff88006f2768f0 R14: 0000000000000600 R15:
>> ffff88006bf6f118 [ 64.881509] FS: 0000000000000000(0000)
>> GS:ffff88007ac00000(0000) knlGS:0000000000000000 [ 64.890545] CS: 0010 D=
S: 0000 ES: 0000 CR0: 0000000080050033 [ 64.896965] CR2: 00000000000000f0 C=
R3: 0000000065c99000 CR4: 00000000003406f0 [ 64.904936] Last Branch Records:
>> [ 64.908551] to: [<ffffffff81a50260>] page_fault+0x0/0x80 [ 64.914787]
>> from: [<ffffffff81736b6d>] rx_fill+0x1ed/0x3b0 [ 64.921020] to:=20
>> [<ffffffff81736b69>] rx_fill+0x1e9/0x3b0 [ 64.927253] from:=20
>> [<ffffffff81736b63>] rx_fill+0x1e3/0x3b0 [ 64.933480] to:=20
>> [<ffffffff81736b37>] rx_fill+0x1b7/0x3b0 [ 64.939704] from:=20
>> [<ffffffff811804bd>] printk+0x4f/0x50 [ 64.945654] to:=20
>> [<ffffffff811804b6>] printk+0x48/0x50 [ 64.951588] from:=20
>> [<ffffffff810ecb60>] vprintk_default+0x20/0x30 [ 64.958403] to:=20
>> [<ffffffff810ecb5f>] vprintk_default+0x1f/0x30 [ 64.965219] from:=20
>> [<ffffffff810ec64f>] vprintk_emit+0x16f/0x530 [ 64.971941] to:=20
>> [<ffffffff810ec641>] vprintk_emit+0x161/0x530 [ 64.978653] from:=20
>> [<ffffffff810ec752>] vprintk_emit+0x272/0x530 [ 64.985383] to:=20
>> [<ffffffff810ec752>] vprintk_emit+0x272/0x530 [ 64.992116] from:=20
>> [<ffffffff81001387>] restore+0xd/0x16 [ 64.998059] to:=20
>> [<ffffffff8100137a>] restore+0x0/0x16 [ 65.003999] from:=20
>> [<ffffffff81001364>] ___preempt_schedule+0x12/0x14 [ 65.011205] to:=20
>> [<ffffffff81001364>] ___preempt_schedule+0x12/0x14 [ 65.018411] from:=20
>> [<ffffffff81a47a60>] preempt_schedule+0x20/0x30 [ 65.025324] to:=20
>> [<ffffffff81a47a5f>] preempt_schedule+0x1f/0x30 [ 65.032228] from:=20
>> [<ffffffff81a47a33>] preempt_schedule_common+0x33/0x40 [ 65.039835]
>> to: [<ffffffff81a47a1f>] preempt_schedule_common+0x1f/0x40 [=20
>> 65.047427] from: [<ffffffff81a471db>] __schedule+0x36b/0xb90 [=20
>> 65.053952] to: [<ffffffff81a471bc>] __schedule+0x34c/0xb90 [=20
>> 65.060478] from: [<ffffffff810c1326>] finish_task_switch+0xb6/0x210 [=20
>> 65.067688] to: [<ffffffff810c12fb>] finish_task_switch+0x8b/0x210 [=20
>> 65.074886] from: [<ffffffff81a4db3a>] _raw_spin_unlock_irq+0x2a/0x40 [=20
>> 65.082190] to: [<ffffffff81a4db2e>] _raw_spin_unlock_irq+0x1e/0x40 [=20
>> 65.089494] from: [<ffffffff810bde65>] preempt_count_sub+0x35/0xb0 [=20
>> 65.096508] to: [<ffffffff810bde5b>] preempt_count_sub+0x2b/0xb0 [=20
>> 65.103511] from: [<ffffffff810bdea5>] preempt_count_sub+0x75/0xb0 [=20
>> 65.110517] to: [<ffffffff810bde9c>] preempt_count_sub+0x6c/0xb0 [=20
>> 65.117522] from: [<ffffffff810bde59>] preempt_count_sub+0x29/0xb0 [=20
>> 65.124530] to: [<ffffffff810bde30>] preempt_count_sub+0x0/0xb0 [=20
>> 65.131444] from: [<ffffffff81a4db29>] _raw_spin_unlock_irq+0x19/0x40 [=20
>> 65.138748] to: [<ffffffff81a4db23>] _raw_spin_unlock_irq+0x13/0x40 [=20
>> 65.146052] from: [<ffffffff81155389>] trace_hardirqs_on+0x9/0xf0 [=20
>> 65.152958] to: [<ffffffff81155380>] trace_hardirqs_on+0x0/0xf0 [=20
>> 65.159872] from: [<ffffffff81a4db1e>] _raw_spin_unlock_irq+0xe/0x40 [=20
>> 65.167065] to: [<ffffffff81a4db1e>] _raw_spin_unlock_irq+0xe/0x40 [=20
>> 65.174257] from: [<ffffffff810e58cb>] do_raw_spin_unlock+0x4b/0xa0 [=20
>> 65.181364] to: [<ffffffff810e5880>] do_raw_spin_unlock+0x0/0xa0 [=20
>> 65.188372] from: [<ffffffff81a4db19>] _raw_spin_unlock_irq+0x9/0x40 [=20
>> 65.195575] to: [<ffffffff81a4db10>] _raw_spin_unlock_irq+0x0/0x40 [=20
>> 65.202776] from: [<ffffffff810c12f6>] finish_task_switch+0x86/0x210 [=20
>> 65.209980] to: [<ffffffff810c1295>] finish_task_switch+0x25/0x210 [=20
>> 65.217183] from: [<ffffffff813dec08>] debug_smp_processor_id+0x18/0x20=20
>> [ 65.224676] to: [<ffffffff813dec07>] debug_smp_processor_id+0x17/0x20=20
>> [ 65.232171] from: [<ffffffff813deb26>]
>> check_preemption_disabled+0x26/0xf0
>> [ 65.239952] to: [<ffffffff813deb00>]
>> check_preemption_disabled+0x0/0xf0
>> [ 65.247632] from: [<ffffffff813dec02>]
>> debug_smp_processor_id+0x12/0x20 [ 65.255124] to: [<ffffffff813debf0>]
>> debug_smp_processor_id+0x0/0x20 [ 65.262521] from:=20
>> [<ffffffff810c1290>] finish_task_switch+0x20/0x210 [ 65.269734] to:=20
>> [<ffffffff810c1270>] finish_task_switch+0x0/0x210 [ 65.276831] from:=20
>> [<ffffffff81a471b7>] __schedule+0x347/0xb90 [ 65.283353] to:=20
>> [<ffffffff81a47184>] __schedule+0x314/0xb90 [ 65.289871] from:=20
>> [<ffffffff81003677>] __switch_to+0x297/0x5a0 [ 65.296486] to:=20
>> [<ffffffff81003666>] __switch_to+0x286/0x5a0 [ 65.303092] from:=20
>> [<ffffffff81003654>] __switch_to+0x274/0x5a0 [ 65.309728] to:=20
>> [<ffffffff81003610>] __switch_to+0x230/0x5a0 [ 65.316352] from:=20
>> [<ffffffff81003600>] __switch_to+0x220/0x5a0 [ 65.322972] to:=20
>> [<ffffffff810035d3>] __switch_to+0x1f3/0x5a0 [ 65.329582] from:=20
>> [<ffffffff810035c3>] __switch_to+0x1e3/0x5a0 [ 65.336203] to:=20
>> [<ffffffff81003525>] __switch_to+0x145/0x5a0 [ 65.342821] from:=20
>> [<ffffffff810034ce>] __switch_to+0xee/0x5a0 [ 65.349343] Stack:
>> [ 65.351585] 0000000000000286 ffff88006bd22548 024000c081a4dae8
>> ffff88006f276918 [ 65.359856] 0000000000000000 0000000000000000
>> ffff88006f276938 ffff88006f2768c0 [ 65.368143] ffff88006f2769a8
>> ffff88007702fe00 ffffffff81736f5f ffff88006f2769a8 [ 65.376447] Call Tra=
ce:
>> [ 65.379176] [<ffffffff81736f5f>] process_rx_w+0xcf/0x130 [ 65.385213]=20
>> [<ffffffff810b29aa>] process_one_work+0x14a/0x450 [ 65.391736]=20
>> [<ffffffff810b2fe6>] worker_thread+0x66/0x450 [ 65.397868]=20
>> [<ffffffff810b2f80>] ? rescuer_thread+0x2d0/0x2d0 [ 65.404391]=20
>> [<ffffffff810b2f80>] ? rescuer_thread+0x2d0/0x2d0 [ 65.410911]=20
>> [<ffffffff810b80ad>] kthread+0xfd/0x120 [ 65.416456]=20
>> [<ffffffff810b7fb0>] ? kthread_create_on_node+0x190/0x190
>> [ 65.423755] [<ffffffff81a4e46f>] ret_from_fork+0x3f/0x70 [ 65.429785]=20
>> [<ffffffff810b7fb0>] ? kthread_create_on_node+0x190/0x190
>> [ 65.437077] Code: 4c 89 c9 41 83 e9 01 4d 63 c9 4d 01 f1 4c 89 c8 48
>> f7 f1 8b 83 b0 00 00 00 49 29 d1 4d 89 ce 85 c0 74 04 4c 0f af f0 48=20
>> 8b 43 18 <80> b8 f0 00 00 00 00 0f 85 78 01 00 00 48 8b 73 20 4c 89 f1
>> 48 [ 65.458462] RIP [<ffffffff81736b6d>] rx_fill+0x1ed/0x3b0 [=20
>> 65.464493] RSP <ffff88007702fd80> [ 65.468388] CR2: 00000000000000f0 [=20
>> 65.472090] ---[ end trace 5a9d1e73247ee2aa ]--- [ 65.479952] Kernel=20
>> panic - not syncing: Fatal exception [ 65.486167] intel_tasks_dumper: in=
tel_task_panic_hndl: Skip tasks dumper.
>> [ 65.493763] reboot: panic mode set: p,w [ 65.498045] Kernel Offset:=20
>> disabled [ 65.509960] Rebooting in 10 seconds..
>>=20
>>=20
>>   I have a patch and I would like to mainline the same patch.
>>   Could you please review the same and provide your comments.
>
> Please submit this in a format that we can apply it in.  We can't apply p=
atchs directly to the 4.4.y tree, they have to be backports from Linus's tr=
ee only (read the stable kernel rules for details.)
>
> Also, your patch referenced a git commit id that is not in Linus's tree, =
and you do not need the Change-Id: line as well.
>
> Please fix that up, and redo it against linux-next and resend and we will=
 be glad to review it.
>
> thanks,
>
> greg k-h
> From b45595c42b75845bac54e11b32d93f396b8c0745 Mon Sep 17 00:00:00 2001
> From: kvaradarajan <Kiruthika.Varadarajan@harman.com>
> Date: Tue, 18 Jun 2019 08:39:06 +0000
> Subject: [PATCH]  USB: Fix race between gether_disconnect and rx_submit
>
>   On spin lock release in rx_submit, gether_disconnect get
>   a chance to run, it makes port_usb NULL, rx_submit access
>   NULL port USB, hence null pointer crash.
>   Fixed by releasing the lock in rx_submit after port_usb
>   is used.
>
>   Signed-off-by:Kiruthika Varadarajan<Kiruthika.Varadarajan@harman.com>
> ---
>  drivers/usb/gadget/function/u_ether.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/f=
unction/u_ether.c
> index 7413f89..e69f20b 100644
> --- a/drivers/usb/gadget/function/u_ether.c
> +++ b/drivers/usb/gadget/function/u_ether.c
> @@ -207,11 +207,12 @@ rx_submit(struct eth_dev *dev, struct usb_request *=
req, gfp_t gfp_flags)
>  		out =3D dev->port_usb->out_ep;
>  	else
>  		out =3D NULL;
> -	spin_unlock_irqrestore(&dev->lock, flags);
>=20=20
>  	if (!out)
> +	{
> +		spin_unlock_irqrestore(&dev->lock, flags);
>  		return -ENOTCONN;
> -
> +	}
>=20=20
>  	/* Padding up to RX_EXTRA handles minor disagreements with host.
>  	 * Normally we use the USB "terminate on short read" convention;
> @@ -232,6 +233,7 @@ rx_submit(struct eth_dev *dev, struct usb_request *re=
q, gfp_t gfp_flags)
>=20=20
>  	if (dev->port_usb->is_fixed)
>  		size =3D max_t(size_t, size, dev->port_usb->fixed_out_len);
> +	spin_unlock_irqrestore(&dev->lock, flags);
>=20=20
>  	skb =3D alloc_skb(size + NET_IP_ALIGN, gfp_flags);
>  	if (skb =3D=3D NULL) {

Thanks, this is a good fix. dev->port_usb should, indeed, be accessed
with spin lock held. I have taken your patch from the attachment this
time around, but keep in mind that this is not how we send patches. We
have documentation explaining how to do so. Also, there were some issues
with your commit log, subject line and signed-off-by line. I've fixed
them all.

I'll resend the fixed up version of the patch so you see how it
should've been.

cheers

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl0IpxQACgkQzL64meEa
mQYqiBAAzkZof9/GgH1u/D54WBNMLMng6Edy9+ntKuvej89t2LqVUVHkcahFfY5a
X6xEfhqmSoURtPtJsD5mUIH3ooUspkTtBN7AbtQSqhQKgnXdJWcsfW9U6rfhXIZB
lpwE4DaFbszKvltsArK9yD1BZss22VYF064dt/xKc7Deu1jHdRFoCfZkpjk4ZB0J
4mnRzM/KMsFVswB90iK8V3sOHDiv3GdatWcYOBy8KnDkfwcbF+p6odYn2F+yguqw
fdrN4oQJeX4jreuz2KNF5208AIozTwsxxzuW4kEQNx/AfVxbPYPNCGOeAUD5KtoH
LiY4QZ7U1mdAAgfr+HUvX5JQKHC1p9Zz3mHh0Ua7adH+ZtBxPCpHf53BEJDadMOh
4PMuDhybLZibELrbmXHT7EKUUuqVe6UxFLB9YNoXvm8iOa8TNiRChsh6IWQYsVKL
3fmeoBZbN6UzUqhSzOFOc5s/l3gZSxInb8y20hTgMT0kTrmvaCFt+X6YWHs1uxas
1gprapcaDrVb7ryCQg6eGCst8bdR4vhFgjiAov1dKX2jUXUthm1l6aHn2kVwmSip
v4Qd2Zg955C0RIZEgW4ivJ0f3coZ56MI0EN6UZtyq2+MG9x685Y6COIkVeWfFIxs
QJylQ4jW8Ue84Vt5Up/rNrZBnhaMTxGlrdhxVchDMTkhDHzO2F0=
=V7pb
-----END PGP SIGNATURE-----
--=-=-=--
