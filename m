Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CF2C10F0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A7432087E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 07:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="SCcCxQ3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfDOH3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 03:29:34 -0400
Received: from onstation.org ([52.200.56.107]:59920 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfDOH3d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 03:29:33 -0400
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 8387C3E8DE;
        Mon, 15 Apr 2019 07:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=onstation.org;
        s=default; t=1555313372;
        bh=AHDwOJ9oFsQEbq92OLbSdzAIUVXg6oyxZSGg22CAm0c=;
        h=From:To:Cc:Subject:Date:From;
        b=SCcCxQ3K/nMElfVk71ldCMToPmxMxt1bAQvhWWrAdEDQpGq8ugyeXaj73SvDIjkoU
         FPOOcJNfQjoKm9BJbeql9DEyP4lYE/2THVOw3/EAA6kEdr8vqTRrQ1PLds6miipRok
         csLsONqz0+R/joEmPEKcvINknExQn+O6CxXefYAI=
From:   Brian Masney <masneyb@onstation.org>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, robh+dt@kernel.org
Cc:     jacek.anaszewski@gmail.com, pavel@ucw.cz, mark.rutland@arm.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dmurphy@ti.com, jonathan@marek.ca
Subject: [PATCH v3 0/3] backlight: lm3630a: bug fix and fwnode support
Date:   Mon, 15 Apr 2019 03:29:02 -0400
Message-Id: <20190415072905.2861-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch series that fixes a single bug and adds fwnode support
to the lm3630a driver. This work was tested on a LG Nexus 5 (hammerhead)
phone. My status page at https://masneyb.github.io/nexus-5-upstream/
describes what is working so far with the upstream kernel.

See the individual patches for the changelog.

Brian Masney (3):
  backlight: lm3630a: return 0 on success in update_status functions
  dt-bindings: backlight: add lm3630a bindings
  backlight: lm3630a: add firmware node support

 .../leds/backlight/lm3630a-backlight.yaml     | 124 ++++++++++++++++
 drivers/video/backlight/lm3630a_bl.c          | 132 +++++++++++++++++-
 2 files changed, 252 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/lm3630a-backlight.yaml

-- 
2.20.1

