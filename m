Return-Path: <SRS0=/Haq=WD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4425CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:59:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A2B821872
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Aug 2019 23:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565222366;
	bh=xlQGs4Ss1PEAXXFBoCe2f1wiOxkqtY6afXuf8TMA9Xw=;
	h=In-Reply-To:References:From:Cc:To:Subject:Date:List-ID:From;
	b=AjVYwTdbIvWDOk4H9unHsMXr4N/YdxB13bJqr04OEtbwDWyXvl3CNO1VrqllN30lv
	 Sup8DIDtPT1K+goh9oTEF6yBYnmGkm8RqmiturfljdOamdOdCqOr5bnhwLRVyAl6DS
	 n8ZqqJeXL3OZ5wbKTnbFXq9HCa7hIUmMNMYVl5HY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388911AbfHGX7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Aug 2019 19:59:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:51464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730045AbfHGX7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Aug 2019 19:59:24 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D714217D9;
        Wed,  7 Aug 2019 23:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565222363;
        bh=xlQGs4Ss1PEAXXFBoCe2f1wiOxkqtY6afXuf8TMA9Xw=;
        h=In-Reply-To:References:From:Cc:To:Subject:Date:From;
        b=Rc4GwQf5rpwauL1csS5qRpDY92wjK/Dpk0A1DPPcgh/V0YCa3P+3ZIsWZ5ZhjOmf+
         JAq4VaPmsevg5gVvmNGKIQwcxSWHA5UuY8suZLnlz2HFwreM07sWviu+W3xPx2TzJY
         P4xr+s0CUvYCi/0zj+BnoWFtJ7JU1oJGqMrDMHAw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAL_JsqKZHG-y_cKitU0=EksgyVU-YLOi1gAcFXx4ve21CMki1g@mail.gmail.com>
References: <20190725020551.27034-1-Anson.Huang@nxp.com> <20190725210619.5EB94218D4@mail.kernel.org> <CAL_JsqKZHG-y_cKitU0=EksgyVU-YLOi1gAcFXx4ve21CMki1g@mail.gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: imx8mn: Fix tab indentation for yaml file
User-Agent: alot/0.8.1
Date:   Wed, 07 Aug 2019 16:59:22 -0700
Message-Id: <20190807235923.9D714217D9@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2019-07-25 14:37:24)
> On Thu, Jul 25, 2019 at 3:06 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Anson.Huang@nxp.com (2019-07-24 19:05:51)
> > > From: Anson Huang <Anson.Huang@nxp.com>
> > >
> > > YAML file can NOT contain tab as indentation, fix it.
> > >
> >
> > Would be nice if checkpatch could check for this.
>=20
> Would be nice if folks just ran 'make dt_binding_check'. :) It
> wouldn't be hard to add a tab check to checkpatch, but that's just one
> potential problem.
>=20

Cool, thanks for the pointer. Seems I forgot :)

Here's a patch to improve the documentation and make help to answer
questions I had about how to work this into my workflow.

diff --git a/Documentation/devicetree/writing-schema.md b/Documentation/dev=
icetree/writing-schema.md
index dc032db36262..17ad67887fde 100644
--- a/Documentation/devicetree/writing-schema.md
+++ b/Documentation/devicetree/writing-schema.md
@@ -120,6 +120,7 @@ This will first run the `dt_binding_check` which genera=
tes the processed schema.
 It is also possible to run checks with a single schema file by setting the
 'DT_SCHEMA_FILES' variable to a specific schema file.
=20
+`make dt_binding_check DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings=
/trivial-devices.yaml`
 `make dtbs_check DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/trivi=
al-devices.yaml`
=20
=20
diff --git a/Makefile b/Makefile
index 9be5834073f8..96bb28aa1c46 100644
--- a/Makefile
+++ b/Makefile
@@ -1503,8 +1503,10 @@ help:
 	@echo  ''
 	@$(if $(dtstree), \
 		echo 'Devicetree:'; \
-		echo '* dtbs            - Build device tree blobs for enabled boards'; \
-		echo '  dtbs_install    - Install dtbs to $(INSTALL_DTBS_PATH)'; \
+		echo '* dtbs             - Build device tree blobs for enabled boards'; \
+		echo '  dtbs_install     - Install dtbs to $(INSTALL_DTBS_PATH)'; \
+		echo '  dt_binding_check - Validate device tree binding documents'; \
+		echo '  dtbs_check       - Validate device tree source files'; \
 		echo '')
=20
 	@echo 'Userspace tools targets:'

