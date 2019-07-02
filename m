Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6576BC06513
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4839920659
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 08:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727073AbfGBItt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 04:49:49 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:55916 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfGBIts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 04:49:48 -0400
Received: from laptop.home (unknown [IPv6:2a01:cb19:8ad6:900:8ae7:f3be:9ccd:d8f9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: aragua)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 18A0D260A91;
        Tue,  2 Jul 2019 09:49:47 +0100 (BST)
From:   Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     gwendal@chromium.org, egranata@chromium.org, kernel@collabora.com,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Nick Vaccaro <nvaccaro@chromium.org>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/1] iio: common: cros_ec_sensors: Add protocol v3 support
Date:   Tue,  2 Jul 2019 10:49:37 +0200
Message-Id: <cover.1562056868.git.fabien.lahoudere@collabora.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is part of a split of the following patch:
https://lkml.org/lkml/2019/6/18/268
To fix Enric comments from https://lkml.org/lkml/2019/6/25/949
I extract it from the other serie to speed up acceptance because
other patches need it to be upstreamed.

Changes since v3:
- Remove unneeded semicolon
- Add Enric Acked-by

Changes since v2:
- Use patch 1 from v1 after discussion on ML

Changes since v1:
- Drop second patch
- return ENODEV if version is 0

Fabien Lahoudere (1):
  iio: common: cros_ec_sensors: determine protocol version

 .../cros_ec_sensors/cros_ec_sensors_core.c    | 36 ++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

-- 
2.19.2

