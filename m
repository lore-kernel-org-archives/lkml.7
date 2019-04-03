Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81FBAC4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:25:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493782084C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 13:25:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=in.bosch.com header.i=@in.bosch.com header.b="rHTFE/AY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726545AbfDCNZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 09:25:49 -0400
Received: from de-deferred1.bosch-org.com ([139.15.180.216]:41768 "EHLO
        de-deferred1.bosch-org.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbfDCNZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 09:25:45 -0400
X-Greylist: delayed 593 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Apr 2019 09:25:42 EDT
Received: from de-out1.bosch-org.com (unknown [139.15.180.215])
        by si0vms0224.rbdmz01.com (Postfix) with ESMTPS id 44Z65b6D5Vz27W;
        Wed,  3 Apr 2019 15:15:47 +0200 (CEST)
Received: from si0vm1947.rbesz01.com (unknown [139.15.230.188])
        by fe0vms0186.rbdmz01.com (Postfix) with ESMTPS id 44Z65Y5xc8z1XLFk0;
        Wed,  3 Apr 2019 15:15:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=in.bosch.com;
        s=2015-01-21; t=1554297345;
        bh=5JmXTCA8402bhLcSZ4Bm03a+Df0e1eFcN7hmyjl8vSI=; l=10;
        h=From:From:Reply-To:Sender;
        b=rHTFE/AY8tcQA0PDs1XzSr3a0ADUMDG36Ch055y8SHKxCFbJbpGkBUj+Xk/RJc5mP
         3rMmT/rA1Tn0TB4zNczgWxbd90YcIDlr9Qk8k4rQ2bmiLxtstGqVutsmAi6xFSatl9
         JZYAr046sVcCf7MzfSSuAqP2LUdtuqSyjnLyOPxs=
Received: from fe0vm02900.rbesz01.com (unknown [10.58.172.176])
        by si0vm1947.rbesz01.com (Postfix) with ESMTPS id 44Z65Y5bYtz6CjQSM;
        Wed,  3 Apr 2019 15:15:45 +0200 (CEST)
X-AuditID: 0a3aad0c-d19ff700000039d6-24-5ca4b2018399
Received: from si0vm1949.rbesz01.com ( [10.58.173.29])
        (using TLS with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by fe0vm02900.rbesz01.com (SMG Outbound) with SMTP id 1D.AF.14806.102B4AC5; Wed,  3 Apr 2019 15:15:45 +0200 (CEST)
Received: from SI-HUB2000.de.bosch.com (si-hub2000.de.bosch.com [10.4.103.108])
        by si0vm1949.rbesz01.com (Postfix) with ESMTPS id 44Z65Y3cpVz6CjZqt;
        Wed,  3 Apr 2019 15:15:45 +0200 (CEST)
Received: from localhost.localdomain (10.47.103.88) by SI-HUB2000.de.bosch.com
 (10.4.103.108) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Wed, 3 Apr 2019
 15:15:44 +0200
From:   <VenkataRajesh.Kalakodima@in.bosch.com>
To:     <linux-renesas-soc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>
CC:     kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>
Subject: [PATCH 0/8] v4.19.0 Added Color Management Module
Date:   Wed, 3 Apr 2019 18:44:36 +0530
Message-ID: <1554297284-14009-1-git-send-email-VenkataRajesh.Kalakodima@in.bosch.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="n"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.103.88]
X-Brightmail-Tracker: H4sIAAAAAAAAA22SbUxTVxzGe+5tL5fKHbeXin8KRXJhy6Yi1QoWncZ9ML4u8kG3ZGkyL+PS
        NlJKelsCbjOsbJiCopJI0toIRj6Idgo3Ksh8wW7qNI4gouJGqDFoFDd8KSzgC9ktBdsP+/Y/
        z/P/nSfnySFxpi1OQ1pKHby9lCthCaVcueJnbTYSW4w6/68fGZp+61EY+sefE4aXe4YUhttd
        PsJw5ukotkaxPlh3DVsfEtMLsK+UnxbxJZZy3p6zervSPNX6Bisb0VacHfqiCg0n16J4Euhl
        0OV5TtQiJcnQHgw6HrsUkcMlBEMHj6HI4W8EwZtXURgh6Gy41N4eFzbUdCuCutEOLGzg9Fqo
        PuGbXkqiV4BrtGZ6ltNZ4Ho2Nj1T9DZwnb5DRLLT4X6PG4/oKrjuGZZH7vkQgv6TM/N8qD5z
        SNohpf0MOHeE2I8SvTGEN4bwxhDNCD+Okot5XblVtzRfp1tsL+SFnboli7+xWUUU6TOhE11p
        MQUQTSI2gXrlaTEyCq5cqLQGUC6JsXOpvF2S9EGhrajSzAnmr+3OEl5gNVRa70Yjk/ReFpyF
        VosgWGylAQQkzqqpm/uajQxVxFXu5O22CBZAqaScnUeZyC1GhjZxDn4Hz5fx9ll3JUmyQKnb
        pUCVnTfxFcWWEseszWopJJPJmORYJzYWI+MDSE8mSNlY+ApKKOOsgsU0g6dEcGZWjaI30HLN
        PKogzNBh1+wsfZ+qSaNkjw4bmbkxRpQcQQNI6i2JendKghOkrxrNAyo1XJFqRoxCS1skhn4X
        D27/Lni6uwrB4c5xBCHfOA4vnlxVQH3vEQKGL4sE7HOfJ6CvyxsH/e6zc2Dywq1EuDLcpQLx
        3h41uEMNahj8vS0Z/uoJpsCfE22pIN6YTAPxj38yoO/10UzodT3MhKm7tVlwztWXBf7zvk/g
        hHhxAQx4Hi6EsTeti0A8MJ4DU43+ZVDv68yFH0PVeXCyrTFvROoSk7o0OJvCXTo4x/90OaNG
        H6epQmk1fRObG57guf75p9dd3/ty07bQl59bsn8q4LoPZfzSI3d02ww1dId+a82/4qr8lEWO
        2uP3F2rWERMjmintZMPY8ms/eFS7gxe83cLFipwDsm8VGYX1/W8fyJs+e1uXPpj5sX7iVTFv
        ve0a0H/fPqi/5wys/G7StEEbh+e/HtyKrWXlgplbsgC3C9x/LgzJWkMEAAA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kalakodima venkata rajesh <venkatarajesh.kalakodima@in.bosch.com>

This patchset adds rcar- display unit color management module (CMM) function feature, Which allows correction and adjustment of the display data, through updating Look up table (gamma) and  Cubic look up table (CTM)  property values 

Base color management module reference code taken from below link,
https://github.com/renesas-rcar/du_cmm .
-	In above code, modified variable namingâ€™s and removed un used functionalities.
-	Introduce new functions for queueing cubic look up table and look up table events.

-	Implemented interfaces in color management module to set CLU /LUT table using standard DRM data structures as input.
	Look up table is a 1D-LUT that converts each of three-color components by using a lookup table. LUT is used for gamma correction.							
	Cubic look up table is a three-dimensional LUT (3D-LUT) that converts the input three-color-component data into desired three color Components by using a lookup table

-	Implemented atomic check helper functions for enable/disable LUT and CLU (Gamma and Color Transformation Matrix properties).
-	Allocated memory necessary for cubic look up table and look up table and added mode fix up callback function
-	Added update gamma and color transformation matrix properties in commit tail function, If any change in property values.

kalakodima venkata rajesh (8):
  drm: Add DU CMM support functions
  drm: Add DU CMM support boot and clk changes
  drm: rcar-du: Give a name to clu table samples
  drm: rcar-du: Refactor the code with new functions
  drm: rcar-du: Implement interfaces to set clu and lut using drm data
    structures
  drm: rcar-du: Implement atomic_check to check for gamma and ctm
    properties
  drm: rcar-du: update gamma and ctm properties in commit tail
  drm: rcar-du: Add shutdown callback function in platform_driver

 .../boot/dts/renesas/r8a7795-es1-salvator-x.dts    |    5 +
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |    5 +
 .../arm64/boot/dts/renesas/r8a7795-salvator-xs.dts |    5 +
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           |   29 +-
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |    6 +-
 .../arm64/boot/dts/renesas/r8a7796-salvator-xs.dts |    4 +
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           |   25 +-
 .../arm64/boot/dts/renesas/r8a77965-salvator-x.dts |    7 +-
 .../boot/dts/renesas/r8a77965-salvator-xs.dts      |    7 +-
 arch/arm64/boot/dts/renesas/r8a77965.dtsi          |   27 +-
 drivers/clk/renesas/r8a7795-cpg-mssr.c             |    4 +
 drivers/clk/renesas/r8a7796-cpg-mssr.c             |    3 +
 drivers/clk/renesas/r8a77965-cpg-mssr.c            |  106 +-
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c          |   35 +
 drivers/gpu/drm/rcar-du/Makefile                   |    2 +
 drivers/gpu/drm/rcar-du/rcar_du_cmm.c              | 1470 ++++++++++++++++++++
 drivers/gpu/drm/rcar-du/rcar_du_crtc.c             |   82 ++
 drivers/gpu/drm/rcar-du/rcar_du_crtc.h             |   28 +
 drivers/gpu/drm/rcar-du/rcar_du_drv.c              |   85 +-
 drivers/gpu/drm/rcar-du/rcar_du_drv.h              |   16 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.c          |    2 +-
 drivers/gpu/drm/rcar-du/rcar_du_encoder.h          |    1 +
 drivers/gpu/drm/rcar-du/rcar_du_group.c            |    5 +
 drivers/gpu/drm/rcar-du/rcar_du_kms.c              |   25 +
 drivers/gpu/drm/rcar-du/rcar_du_regs.h             |   92 ++
 include/drm/bridge/dw_hdmi.h                       |    1 +
 include/drm/drm_atomic.h                           |   25 +
 include/drm/drm_ioctl.h                            |    7 +
 28 files changed, 2082 insertions(+), 27 deletions(-)
 create mode 100644 drivers/gpu/drm/rcar-du/rcar_du_cmm.c

-- 
2.7.4

