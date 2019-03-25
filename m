Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4924C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A154120848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:25:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbfCYVZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:25:06 -0400
Received: from smtprelay0197.hostedemail.com ([216.40.44.197]:34557 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730570AbfCYVZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:25:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id AF57F1803671A;
        Mon, 25 Mar 2019 21:25:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: road04_e82f4da6ea63
X-Filterd-Recvd-Size: 4261
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 21:24:59 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        patches@opensource.cirrus.com, Lee Jones <lee.jones@linaro.org>
Subject: Bad file pattern in MAINTAINERS section 'CIRRUS LOGIC LOCHNAGAR DRIVER'
Date:   Mon, 25 Mar 2019 14:24:58 -0700
Message-Id: <20190325212458.26072-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A file pattern line in this section of the MAINTAINERS file in linux-next
does not have a match in the linux source files.

This could occur because a matching filename was never added, was deleted
or renamed in some other commit.

The commits that added and if found renamed or removed the file pattern
are shown below.

Please fix this defect appropriately.

1: ---------------------------------------------------------------------------

linux-next MAINTAINERS section:

	3792	CIRRUS LOGIC LOCHNAGAR DRIVER
	3793	M:	Charles Keepax <ckeepax@opensource.cirrus.com>
	3794	M:	Richard Fitzgerald <rf@opensource.cirrus.com>
	3795	L:	patches@opensource.cirrus.com
	3796	S:	Supported
	3797	F:	drivers/clk/clk-lochnagar.c
	3798	F:	drivers/mfd/lochnagar-i2c.c
-->	3799	F:	drivers/pinctrl/cirrus/pinctrl-lochnagar.c
	3800	F:	drivers/regulator/lochnagar-regulator.c
	3801	F:	sound/soc/codecs/lochnagar-sc.c
	3802	F:	include/dt-bindings/clk/lochnagar.h
	3803	F:	include/dt-bindings/pinctrl/lochnagar.h
	3804	F:	include/linux/mfd/lochnagar*
	3805	F:	Documentation/devicetree/bindings/mfd/cirrus,lochnagar.txt
	3806	F:	Documentation/devicetree/bindings/clock/cirrus,lochnagar.txt
	3807	F:	Documentation/devicetree/bindings/pinctrl/cirrus,lochnagar.txt
	3808	F:	Documentation/devicetree/bindings/regulator/cirrus,lochnagar.txt
	3809	F:	Documentation/devicetree/bindings/sound/cirrus,lochnagar.txt

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'drivers/pinctrl/cirrus/pinctrl-lochnagar.c':

commit 422dcafe477c7240d03c7b150704c45e0b17be57
Author: Charles Keepax <ckeepax@opensource.cirrus.com>
Date:   Wed Jan 30 11:41:26 2019 +0000

    mfd: lochnagar: Add support for the Cirrus Logic Lochnagar
    
    Lochnagar is an evaluation and development board for Cirrus
    Logic Smart CODEC and Amp devices. It allows the connection of
    most Cirrus Logic devices on mini-cards, as well as allowing
    connection of various application processor systems to provide a
    full evaluation platform. This driver supports the board
    controller chip on the Lochnagar board. Audio system topology,
    clocking and power can all be controlled through the Lochnagar
    controller chip, allowing the device under test to be used in
    a variety of possible use cases.
    
    As the Lochnagar is a fairly complex device this MFD driver
    allows the drivers for the various features to be bound
    in. Initially clocking, regulator and pinctrl will be added as
    these are necessary to configure the system. But in time at least
    audio and voltage/current monitoring will also be added.
    
    Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
    Signed-off-by: Lee Jones <lee.jones@linaro.org>

 MAINTAINERS                         |  17 ++
 drivers/mfd/Kconfig                 |   8 +
 drivers/mfd/Makefile                |   2 +
 drivers/mfd/lochnagar-i2c.c         | 398 ++++++++++++++++++++++++++++++++++++
 include/linux/mfd/lochnagar.h       |  55 +++++
 include/linux/mfd/lochnagar1_regs.h | 157 ++++++++++++++
 include/linux/mfd/lochnagar2_regs.h | 291 ++++++++++++++++++++++++++
 7 files changed, 928 insertions(+)

3: ---------------------------------------------------------------------------

No commit with file pattern 'drivers/pinctrl/cirrus/pinctrl-lochnagar.c' was found
