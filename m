Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45912C04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18A242087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 16:11:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fqQDbDar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbfEQQLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 12:11:47 -0400
Received: from mout.gmx.net ([212.227.15.15]:59985 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729163AbfEQQLr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 12:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1558109490;
        bh=ObVsCKoy24nyR+PE5lyuwbL6rGIGz6OGgJWXUYTs8Gc=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=fqQDbDarvk1j260RMG1ySbxWBkJAQIhtWUp29JDmoJrZGizSYh620SlDIF13rkOQT
         t4enlnwpAgGrJ3kuP9k3TRo1xX/qAtpFsMEAkK03M7s1RylbLw7KWPdGT3A6yM91sA
         IrQLLKxr6F5mp4FMrIApwKuxFBcdtOXp0ozigY8w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from macchiato.fritz.box ([84.118.159.3]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MSdNs-1hHjJ00w68-00RWe0; Fri, 17
 May 2019 18:11:30 +0200
From:   Heinrich Schuchardt <xypron.glpk@gmx.de>
To:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Heinrich Schuchardt <xypron.glpk@gmx.de>
Subject: [PATCH 1/1] arm64: dts: marvell: mcbin: enlarge PCI memory window
Date:   Fri, 17 May 2019 18:11:23 +0200
Message-Id: <20190517161123.9293-1-xypron.glpk@gmx.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hCNjLnr3ec6akbhn/dmwopTmrwD2ngfwxcwNRx8GXCrYkJA0EpJ
 L5UcXsGJelQo6uQlfzMgiqLsfqw3RElPw9lrnRcjjwRR9gJcmj1rrRavn1HvVShlaCU+Enq
 Egozfv7Y/B6s88noZPevX9LpD7kNku6iptetaBWgDjfD10dJMtbxmeENjqoUVoWbJ4oCLar
 XOelF3caKICXi3KXxsccQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:OcrfSlw1JQ8=:GN1/4inuw1Bj7DI4AR2yOE
 kenLvJPUoIGFq7CquaGL3nQdBdCj1yHykf2FsJQJHIPVtxiuL7LbrWOhwMHEzLTNDd6YHMLFM
 py2hQ0SYwIKrHw/1lFlBtN8pJU/FfSJs3RjxBW+ZHwv/uRM0frc2txp2WV8qsNhzvixSLqmeg
 gPPL73apNRQHlv3euqNA+3OzjZBicRpOukofYNwkuzclIkKX4p2KNqyAjUMAxkmbZNIDJ/gTB
 7EeVZmNC6a8YNC1r5z71uhWM0vPITUuD1/lx6kEnd04y+ftqzyoHriL0y727mJDxItIG/M5Jh
 p5ZxnMHqsC9hhoVnaVdwWHsQhbGgqTi75WnZ/dkSPzj8p52WrUiPdxVLQ3bxQNmxXn68qk6Ki
 sTP0ULeONcC4xgmdPtOPRhFgRh8rb+fN1wshsiZOm/qr+V4tULGYcOoDMmQgdbRf2gG75yW3T
 U+xs7MvfZUyP2RVoIjpciq3uzzq5GPxfCefxFoJgR6dxOP8IpSRPOZHMbtVZJBEhCFKKTd7GD
 aWnaPa6q0LWGlEB9VfBPGngG5MLOZs4TFK4j2RHpui9wxMjwMD9vIaHS2hMIDOHbDwNt7V2Vm
 My4aO7y53osFxqQleVUXmA4n/VvpZW5nxcl2bIx+8xUD3vFEzpaLCY9GaYPCyh4OlYWA+D8Wt
 HYT1DH2/UK7Rd2Pe7yBnfOBgeGe3GWmn7uGpT8dHdT0ofIvRcF/0fYqMhuYko3WLq1hjXmdV8
 lIgJnIEHbHh2ub17m2hQo3yj2OwJFQbwP2XKw0Z1ILw8m+enl7gUZ2m9yoz1XJ24qlJpDHPpS
 fUou0epAwa2ZNgnPHW7SGFA72qMWSnCM20OB+OdgGgoOhF3g6ozC/1buxhkxnLMR5W0jYjSab
 TMvM9yFgotVEQK3OamifYbAg0oV3Pnw2muyxD0dKvNWAru6lHOiybnkKjKUfP3J6ooUKtSjBc
 6LSRQ7VCs4Jg823WxYvLwdCi4JvvpZCw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Running a graphics adapter on the MACCHIATObin fails due to an
insufficently sized memory window.

Enlarge the memory window for the PCIe slot to 512 MiB.

With the patch I am able to use a GT710 graphics adapter with 1 GB onboard
memory.

These are the mapped memory areas that the graphics adapter is actually
using:

Region 0: Memory at cc000000 (32-bit, non-prefetchable) [size=3D16M]
Region 1: Memory at c0000000 (64-bit, prefetchable) [size=3D128M]
Region 3: Memory at c8000000 (64-bit, prefetchable) [size=3D32M]
Region 5: I/O ports at 1000 [size=3D128]
Expansion ROM at ca000000 [disabled] [size=3D512K]

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
=2D--
 arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi b/arch/arm=
64/boot/dts/marvell/armada-8040-mcbin.dtsi
index 329f8ceeebea..205071b45a32 100644
=2D-- a/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-8040-mcbin.dtsi
@@ -184,6 +184,8 @@
 	num-lanes =3D <4>;
 	num-viewport =3D <8>;
 	reset-gpios =3D <&cp0_gpio2 20 GPIO_ACTIVE_LOW>;
+	ranges =3D <0x81000000 0x0 0xf9010000 0x0 0xf9010000 0x0 0x10000
+		  0x82000000 0x0 0xc0000000 0x0 0xc0000000 0x0 0x20000000>;
 	status =3D "okay";
 };

=2D-
2.20.1

