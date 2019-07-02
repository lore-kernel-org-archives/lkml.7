Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5F5C06511
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:41:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C3621721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 09:41:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="BKziDrDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbfGBJlP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 05:41:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:57855 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbfGBJlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 05:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1562060458;
        bh=f6kRXJnx0iuLcJu8Xdd4njzNEX/9pGEhKGohBWOOTnU=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BKziDrDKtqG4PEH5TiBq1a7WBSS4JlDEg6vQiLLnMIUnaZ9J0mQeMU6Rw7uhUxIs8
         +RKQaEYusoYye9S4Att7DUo6Zi2N9IZkhI2TTtsAmzcNszbKAvLV6+hIyo7oSBsjK/
         L5+ZkcmqyyCRtmcCSnXMTi3nsfzqzqGVYKUzh3WM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([217.61.147.59]) by mail.gmx.com
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M59C8-1hjLDB4900-001Ae7; Tue, 02 Jul 2019 11:40:58 +0200
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Josef Friedl <josef.friedl@speed.at>
Subject: [PATCH 2/3] add dts for poweroff
Date:   Tue,  2 Jul 2019 11:40:44 +0200
Message-Id: <20190702094045.3652-3-frank-w@public-files.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190702094045.3652-1-frank-w@public-files.de>
References: <20190702094045.3652-1-frank-w@public-files.de>
X-Provags-ID: V03:K1:WVevwR0Nk1xxgXKDn/OupV4Xtu2YX9P9Gipa9pWYtJFb5S1L5GP
 eTPpkrtcjoWfKZI8M/vF4fIgmhDM2w24Zw9wlsZG2v9Y8v3LjsoOMQYFcbvgCjhtZtHA7NA
 FnJYqeguCX52RPIWMyp+fbIvFdhn8zr8svro2mlzPPcetmUJLHAW/Z6s612a4q4e/6VgWcB
 i7+4xz9BCdG7KSuZTFoqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TYy+FGe1yz8=:OPybtfWj9RkoIpOblvgqL7
 rF8ByWKvTBgGbudq2IcFeaOVIg2w4ykQ5XLBv/pzBIsFLvoklHAQ7QCNlAHN4jXtiB+DsL9Fj
 eSzYP0AoSLlzjP3z+3J3HPNe1tAfAq2HPIvcUEpIF4Am/7X5jK+fN3iCIZt4BzmzVFmPF8fPX
 42xgy+i70X17keXI6NtFc1tUmR5ib82RQWg1GNF/Juu0hFVkgHeiBGMKdTtCe65Af1rPqFOVw
 6OXz0CMS40fzqoIJKc9Lx4t/MHUaaPAexxUOj3z+3j+sryNI2FngQN4dvcncxY2Bdd5krS8jQ
 oGFfDmVV7oInaE8NvmPa3e6uZqqR4jaibfDErzEiahI54ChFmMuP+o0h5DbroH6XOLm1ymyiD
 nEapizIGIcSFhGUrWocjBzGrHVtpTCgbjXe1esw1AUhfM/DADVkJg7MVEpKTLyd8dh3XcO7VA
 Qq18xeiv2rgqEW++u0bcTuF94qngZmkgNLJjaaWSH3WxiEhFuLJFbdbuFXEGPCcWwwSWmATyK
 dcszWDE1cbdrf1fzortfrU1MryOmXt2A8OBk1occcvuwjNCH0AwwwnEjTrk9QyI8LOS1RUKiZ
 NOmvd4jSAD9tj/9MlflHj2TfNZ4v8byhgy8G3FiIdHbuZiJimK9q31xQzbx0ATEchRUf94oa+
 1lOWzu1lnS/hlhuhpnbQUuumQJ+nSD5/5yJD6gTUqFWjKKPjIRJZkCrxVkpPLuNEvtfI95Aii
 o5+Obw0Tx1Lsm6+PQtYc+4nP+xGrSk0ESv6nAli+dhOVcaXjvI4xOGCP+ujNbDECU6mpjPXui
 QU/L7qpCNfbuw96eN44o5+WuzIgpLL6JZNBv+9D+Iq8ySFB0uy8vebXxAGgY9Wfz04MnGKhzj
 /t+jXv9xk12B9ma0CmjIxdsw6cPpUqAeKqg94t+DVmqFkzS8sJfywn1bGmvazCSKgFkOjTbIX
 6dphHmcoa0lB6X1RBQaps5v/KVRcOyJxxoZKIG+lrmMip2d4zX0j5g1J60VILwU4PsW1gIJSa
 lJzmGaipRmvN3j547B/OtUF6IxrAv7Tnnziw+LAYXbWpYoeb9/AXvs4BlXoTHkzi8V+7yYlli
 3oz4zhKsW7FN9k=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josef Friedl <josef.friedl@speed.at>

poweroff for BPI-R2
Suggested-by: Frank Wunderlich <frank-w@public-files.de>

Signed-off-by: Josef Friedl <josef.friedl@speed.at>
=2D--
 arch/arm/boot/dts/mt6323.dtsi | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/arm/boot/dts/mt6323.dtsi b/arch/arm/boot/dts/mt6323.dtsi
index ba397407c1dd..7fda40ab5fe8 100644
=2D-- a/arch/arm/boot/dts/mt6323.dtsi
+++ b/arch/arm/boot/dts/mt6323.dtsi
@@ -238,5 +238,32 @@
 				regulator-enable-ramp-delay =3D <216>;
 			};
 		};
+
+		mt6323keys: mt6323keys {
+			compatible =3D "mediatek,mt6323-keys";
+			mediatek,long-press-mode =3D <1>;
+			power-off-time-sec =3D <0>;
+
+			power {
+				linux,keycodes =3D <116>;
+				wakeup-source;
+			};
+
+			home {
+				linux,keycodes =3D <114>;
+			};
+		};
+
+		codec: mt6397codec {
+			compatible =3D "mediatek,mt6397-codec";
+		};
+
+		power-controller {
+			compatible =3D "mediatek,mt6323-pwrc";
+		};
+
+		rtc {
+			compatible =3D "mediatek,mt6323-rtc";
+		};
 	};
 };
=2D-
2.17.1

