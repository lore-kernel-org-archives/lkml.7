Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 377CCC47404
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2BD206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 17:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfJGRqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 13:46:12 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60814 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728081AbfJGRqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 13:46:12 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: ezequiel)
        with ESMTPSA id A31F428D406
From:   Ezequiel Garcia <ezequiel@collabora.com>
To:     linux-media@vger.kernel.org
Cc:     kernel@collabora.com,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-rockchip@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Alexandre Courbot <acourbot@chromium.org>,
        fbuergisser@chromium.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>
Subject: [PATCH v2 for 5.4 0/4] media: hantro: Collected fixes for v5.4
Date:   Mon,  7 Oct 2019 14:45:01 -0300
Message-Id: <20191007174505.10681-1-ezequiel@collabora.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some pending fixes. The first patch is needed to allow
dynamic resolution changes, as per the upcoming stateless
decoder API. This patch was posted before and received
some comments from Philipp Zabel.

The second patch was posted by Jonas Karlman as part
of his series to add support for interlaced content.
The fix can be applied independently so I'm including it
here.

Patches 3 and 4 correspond to fixes found by Francois Buergisser
while doing some tests on ChromeOS.

Ezequiel Garcia (1):
  media: hantro: Fix s_fmt for dynamic resolution changes

Francois Buergisser (2):
  media: hantro: Fix motion vectors usage condition
  media: hantro: Fix picture order count table enable

Jonas Karlman (1):
  media: hantro: Fix H264 max frmsize supported on RK3288

 .../staging/media/hantro/hantro_g1_h264_dec.c |  6 ++--
 drivers/staging/media/hantro/hantro_v4l2.c    | 28 +++++++++++++------
 drivers/staging/media/hantro/rk3288_vpu_hw.c  |  4 +--
 3 files changed, 24 insertions(+), 14 deletions(-)

-- 
2.22.0

