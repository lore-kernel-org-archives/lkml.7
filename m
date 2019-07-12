Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9AFC742CF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08F5B206B8
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 16:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HsJAwp6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfGLQAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 12:00:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48427 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726992AbfGLQAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 12:00:02 -0400
Received: from [IPv6:2601:646:8600:3281:4501:6781:c7ce:2878] ([IPv6:2601:646:8600:3281:4501:6781:c7ce:2878])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x6CFxoFC3480993
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Fri, 12 Jul 2019 08:59:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x6CFxoFC3480993
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1562947191;
        bh=9IwI1hiGYC+jvzVrA/mLfDxJCPPSOKGjVttUTcT08X8=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=HsJAwp6xqQfDnDihPer8Yps4RKOyZiFo1h7NwKbECjBF/fDvIP6zew++znCsgG0XY
         Dcedf4+od5bGv1nQlJkOXsI6kjfYOKLJbT1WpF83rCH2j1hdJXE7visEryhqxAK2Nd
         9GTg3jjQUV6noaR/l9wv0HNaCp0ZJvdeOpGioaT0DLGmrp2uw//zX9MEXHe8gleea2
         uXwJtp7GgtDrBUznALgYZJEmp86EVGYn8BcUplMH69FPH6auBnq40YfuiVxdW6BeUf
         2gDbdH7gpzosIjea1KfQ2+G66VsdJJergLbSGh7AD6i1c6yZTyoaO3LORdOMC9yE8K
         fadkFvJIMVw7Q==
Date:   Fri, 12 Jul 2019 08:59:43 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20190704163612.14311-4-daniel.kiper@oracle.com>
References: <20190704163612.14311-1-daniel.kiper@oracle.com> <20190704163612.14311-4-daniel.kiper@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 3/3] x86/boot: Introduce the kernel_info.setup_type_max
To:     Daniel Kiper <daniel.kiper@oracle.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
CC:     bp@alien8.de, corbet@lwn.net, dpsmith@apertussolutions.com,
        eric.snowberg@oracle.com, kanth.ghatraju@oracle.com,
        konrad.wilk@oracle.com, mingo@redhat.com,
        ross.philipson@oracle.com, tglx@linutronix.de
From:   hpa@zytor.com
Message-ID: <B5CAF3FB-1E8D-498A-81F6-171A37EC1AC2@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 4, 2019 9:36:12 AM PDT, Daniel Kiper <daniel=2Ekiper@oracle=2Ecom> =
wrote:
>This field contains maximal allowed type for setup_data and
>setup_indirect structs=2E
>
>And finally bump setup_header version in arch/x86/boot/header=2ES=2E
>
>Suggested-by: H=2E Peter Anvin <hpa@zytor=2Ecom>
>Signed-off-by: Daniel Kiper <daniel=2Ekiper@oracle=2Ecom>
>Reviewed-by: Ross Philipson <ross=2Ephilipson@oracle=2Ecom>
>Reviewed-by: Eric Snowberg <eric=2Esnowberg@oracle=2Ecom>
>---
> Documentation/x86/boot=2Erst             | 10 +++++++++-
> arch/x86/boot/compressed/kernel_info=2ES |  4 ++++
> arch/x86/boot/header=2ES                 |  2 +-
> arch/x86/include/uapi/asm/bootparam=2Eh  |  3 +++
> 4 files changed, 17 insertions(+), 2 deletions(-)
>
>diff --git a/Documentation/x86/boot=2Erst b/Documentation/x86/boot=2Erst
>index 23d3726d54fc=2E=2E63609fd0517f 100644
>--- a/Documentation/x86/boot=2Erst
>+++ b/Documentation/x86/boot=2Erst
>@@ -73,7 +73,8 @@ Protocol 2=2E14:	BURNT BY INCORRECT COMMIT
>ae7e1238e68f2a472a125673ab506d49158c188
> 		(x86/boot: Add ACPI RSDP address to setup_header)
> 		DO NOT USE!!! ASSUME SAME AS 2=2E13=2E
>=20
>-Protocol 2=2E15:	(Kernel 5=2E3) Added the kernel_info and setup_indirect=
=2E
>+Protocol 2=2E15:	(Kernel 5=2E3) Added the kernel_info,
>kernel_info=2Esetup_type_max
>+		and setup_indirect=2E
>=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> =2E=2E note::
>@@ -980,6 +981,13 @@ Offset/size:	0x0004/4
>This field contains the size of the kernel_info including
>kernel_info=2Eheader=2E
>It should be used by the boot loader to detect supported fields in the
>kernel_info=2E
>=20
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>+Field name:	setup_type_max
>+Offset/size:	0x0008/4
>+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>+
>+  This field contains maximal allowed type for setup_data and
>setup_indirect structs=2E
>+
>=20
> The Image Checksum
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>diff --git a/arch/x86/boot/compressed/kernel_info=2ES
>b/arch/x86/boot/compressed/kernel_info=2ES
>index 3f1cb301b9ff=2E=2E2f28aabf6558 100644
>--- a/arch/x86/boot/compressed/kernel_info=2ES
>+++ b/arch/x86/boot/compressed/kernel_info=2ES
>@@ -1,5 +1,7 @@
> /* SPDX-License-Identifier: GPL-2=2E0 */
>=20
>+#include <asm/bootparam=2Eh>
>+
> 	=2Esection "=2Erodata=2Ekernel_info", "a"
>=20
> 	=2Eglobal kernel_info
>@@ -9,4 +11,6 @@ kernel_info:
> 	=2Eascii	"InfO"
>         /* Size=2E */
> 	=2Elong	kernel_info_end - kernel_info
>+        /* Maximal allowed type for setup_data and setup_indirect
>structs=2E */
>+	=2Elong	SETUP_TYPE_MAX
> kernel_info_end:
>diff --git a/arch/x86/boot/header=2ES b/arch/x86/boot/header=2ES
>index ec6a25a43148=2E=2E893a456663ab 100644
>--- a/arch/x86/boot/header=2ES
>+++ b/arch/x86/boot/header=2ES
>@@ -300,7 +300,7 @@ _start:
> 	# Part 2 of the header, from the old setup=2ES
>=20
> 		=2Eascii	"HdrS"		# header signature
>-		=2Eword	0x020d		# header version number (>=3D 0x0105)
>+		=2Eword	0x020f		# header version number (>=3D 0x0105)
> 					# or else old loadlin-1=2E5 will fail)
> 		=2Eglobl realmode_swtch
> realmode_swtch:	=2Eword	0, 0		# default_switch, SETUPSEG
>diff --git a/arch/x86/include/uapi/asm/bootparam=2Eh
>b/arch/x86/include/uapi/asm/bootparam=2Eh
>index aaaa17fa6ad6=2E=2E2ba870dae6f3 100644
>--- a/arch/x86/include/uapi/asm/bootparam=2Eh
>+++ b/arch/x86/include/uapi/asm/bootparam=2Eh
>@@ -12,6 +12,9 @@
> #define SETUP_JAILHOUSE			6
> #define SETUP_INDIRECT			7
>=20
>+/* max(SETUP_*) */
>+#define SETUP_TYPE_MAX			SETUP_INDIRECT
>+
> /* ram_size flags */
> #define RAMDISK_IMAGE_START_MASK	0x07FF
> #define RAMDISK_PROMPT_FLAG		0x8000

Bump the version number and add setup_max before adding the indirect stuff=
=2E That will nicely double as at the very least a first-order validity che=
ck=2E

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
