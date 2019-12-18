Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9714C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD1AC2176D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="fe2soDgP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbfLRWfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 17:35:51 -0500
Received: from mout.web.de ([217.72.192.78]:43107 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726387AbfLRWft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1576708540;
        bh=8ZRx4y81hHZJO5QcZ9dH2x8e4A8ig8L8U4hPDWTL4Fk=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=fe2soDgPKrDPbLobU0YHjkE1t5sDoCYUJEGoHfb/g/2Z7KqElN/UdgAHwRZmDiREc
         PcaTYrxfy/Ijwr3D/A6W8IqwtR4Fne5eNZq6ahFYtX5L5vQkbX+dufqJIjfaOpwwzj
         TBpG+e7BY1l0lhVCEa1ldJhF7XRL47qOfuMn1hF4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost.localdomain ([89.204.137.218]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0LkyEb-1i9kXm43q1-00andm; Wed, 18 Dec 2019 23:35:40 +0100
From:   Soeren Moch <smoch@web.de>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Soeren Moch <smoch@web.de>, Robin Murphy <robin.murphy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] arm64: dts: rockchip: RockPro64: hook up bluetooth at uart0
Date:   Wed, 18 Dec 2019 23:35:23 +0100
Message-Id: <20191218223523.30154-3-smoch@web.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218223523.30154-1-smoch@web.de>
References: <20191218223523.30154-1-smoch@web.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l+ItjJlDtrlJ5iojY1W0IyP/csk5hm2m8TkpvkslsWVninqUkpA
 ipZrdB6978T9oj9RLdlqMYhKf0Qbh8NeKm8W+z/MQkNBVQ/XpiFWMvsaA/4wbaR/xTEVvc9
 sFRkTUen1CfyoiWXVNXvtuAHlGOSSJjDIsW3od43x49M26JZsQT7SnbNo1KkW3NL/L6l5Tm
 w2M9Q9ABcjb9MQvpperqA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CbjWo1dqzEg=:Hbg+q57jVTLeibDUB3tmYB
 eRtooKn3Rjj28azAkhZ5O1P9Y2+u3I8PLA7rCufMqYwuli8FdZA4Psktiak87x2+2xvtmCA6N
 Zdlgn/pC+p3wNYQOOEFhHRJwbFn6ObVOyxVjQZ4zKf8zz/bVtHFVdQeS4mbZgnBFOV9cqdDfA
 THGLaa9bIF8iB9O+Nn7Gd5tOg3z3PNB1eT2uGNKCSc+T4JoaTjiiwQUx/TLWBTpI6S6gWLpAO
 u7BErTwJ868JilKT5usTdVMOchGIUIQI21+iJ2/Zmua0zUvwSphemKVrNpjX/RNajQOLqcBpD
 EPZvSm6pb4CFiSDUxaEs+3CwDlvQGnU5KajQeo8CSUlf14QyJlnWSjeREcq+6mh6+W3fh1MCC
 +wQzpfNnglBRgYJ/sbyWD7U/fUIly4Aq2G3O1hXptrtLCDCZNOkhotw6+XmrE3fS1IilIROZS
 S/SsBiYWysdO97ZUlETBuPWGslruHPv9h2c3/KQGltXOLy/Q4KEudxg8BRqm/7XLWr+vIW+uq
 f7EGWCGNB711qBhqccfwXGdlD3ti3OD0Fxrcsxu1xsebbDvs4SNj5C4aJPVpDa06d9R3cM7Sq
 WMfSgG5WQK02zxb8FuXInHm0bXsOO+sKB1sjE9DcmqyjE6y5odGVtWDVcdBnoyqNYVcmw5MX0
 JT+2ntrWifF0nQgNXpZPcct0bomAbpRPJecXxFOdWD8FxTVBEYR7FnjKAI34G6Bci5veqrFqa
 T3/dEhFQKrwXx1vT7bDPY7eR5PB2GSUqO6CEH5rgTVnvXr/BoJNOMi+AUHfIJe0lhilw4Tl9B
 252vNQPyhXqTD0vRK+CvSMXVcus4ot7K0eRc2bZvPCbtJBrJTgvqOSXg7viw0XNG0gmB70SCI
 0yT6GzmVyXavOd8OSdIAcD7o56xVFwQshJkV+AMEIN/00VMFYyNZBwLFVm5QMZzwNA6iQn1md
 Jt7VUNzNuf1S4ztJfDIF4+TLogciV/69b/NpsHmyDwRPLWr3He7vJ1DmK0yn0NcPCZ5lvQjAC
 d/YJht5XNvSGJYg2JIXFAueYDSSC7juWdMSFs2y5wOOYNjIx5ozXyeMScssdZ6mZOM9jZ7m5f
 PSYgsDqE/D3rFE1f9tnER+wA5Lsmbv4yfG5/btl3/fCF4d1l6lhBOh27T7Vv+JVxccSXPpz8N
 x5Bbjct/VQLe8X9u6Aj7xsbfMc8ewlogHEQLLIIoXcqnYtOHKbV2jAE8HuITHZdkn14fIHsqB
 eiceuuOwQXnJkqUFlSiBIHXtjXZHzO1gBdd81uQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With enabled wifi support (required for firmware loading) for the
Ampak AP6359SA based wifi/bt combo module we now also can enable
the bluetooth part.

Suggested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Soeren Moch <smoch@web.de>
=2D--
changes in v3:
- fix bluetooth clock name as reported by Robin Murphy
changes in v2:
- new patch

Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
=2D--
 .../boot/dts/rockchip/rk3399-rockpro64.dts    | 29 ++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm6=
4/boot/dts/rockchip/rk3399-rockpro64.dts
index 9fa92790d6e0..d9206730c88c 100644
=2D-- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
@@ -561,6 +561,20 @@
 };

 &pinctrl {
+	bt {
+		bt_enable_h: bt-enable-h {
+			rockchip,pins =3D <0 RK_PB1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		bt_host_wake_l: bt-host-wake-l {
+			rockchip,pins =3D <0 RK_PA4 RK_FUNC_GPIO &pcfg_pull_down>;
+		};
+
+		bt_wake_l: bt-wake-l {
+			rockchip,pins =3D <2 RK_PD3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
 	buttons {
 		pwrbtn: pwrbtn {
 			rockchip,pins =3D <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>;
@@ -729,8 +743,21 @@

 &uart0 {
 	pinctrl-names =3D "default";
-	pinctrl-0 =3D <&uart0_xfer &uart0_cts>;
+	pinctrl-0 =3D <&uart0_xfer &uart0_cts &uart0_rts>;
 	status =3D "okay";
+
+	bluetooth {
+		compatible =3D "brcm,bcm43438-bt";
+		clocks =3D <&rk808 1>;
+		clock-names =3D "lpo";
+		device-wakeup-gpios =3D <&gpio2 RK_PD3 GPIO_ACTIVE_HIGH>;
+		host-wakeup-gpios =3D <&gpio0 RK_PA4 GPIO_ACTIVE_HIGH>;
+		shutdown-gpios =3D <&gpio0 RK_PB1 GPIO_ACTIVE_HIGH>;
+		pinctrl-names =3D "default";
+		pinctrl-0 =3D <&bt_host_wake_l &bt_wake_l &bt_enable_h>;
+		vbat-supply =3D <&vcc3v3_sys>;
+		vddio-supply =3D <&vcc_1v8>;
+	};
 };

 &uart2 {
=2D-
2.17.1

