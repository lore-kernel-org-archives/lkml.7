Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B6B5C06510
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:43:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0ACA12173C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 13:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbfGANnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 09:43:11 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:52960 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfGANnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 09:43:10 -0400
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: from pc-niv.weinmann.com (localhost [127.0.0.1])
        by mail.steuer-voss.de (Postfix) with ESMTP id 309B24D08B;
        Mon,  1 Jul 2019 15:43:07 +0200 (CEST)
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Andreas Dannenberg <dannenberg@ti.com>,
        "Andrew F. Davis" <afd@ti.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
Cc:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org, nv@vosn.de
Subject: [PATCH v2 0/2] ASoC: tas5720.c: add ACPI enumeration support
Date:   Mon,  1 Jul 2019 15:42:50 +0200
Message-Id: <cover.1561988282.git.nikolaus.voss@loewensteinmedical.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190628143037.GH5379@sirena.org.uk>
References: <20190628143037.GH5379@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 1 aggregates variant specific stuff in a struct which is
directly referenced in the id tables (no functional change).

Patch 2 actually adds ACPI IDs for the two DAC variants and uses the
device match API to get the variant in a firmware agnostic manner.

v2:
- split patch into series as suggested by Mark Brown and Andrew F. Davis.
- don't integrate variant data into variant struct but reference it
  (suggested by Andrew F. Davis).

Nikolaus Voss (2):
  ASoC: tas5720.c: cleanup variant management
  ASoC: tas5720.c: add ACPI enumeration support

 sound/soc/codecs/tas5720.c | 111 +++++++++++++++----------------------
 1 file changed, 46 insertions(+), 65 deletions(-)

-- 
2.17.1

