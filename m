Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26393C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F15AC2064B
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 16:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732269AbfFTQR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 12:17:28 -0400
Received: from mga11.intel.com ([192.55.52.93]:58983 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbfFTQR2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 12:17:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jun 2019 09:17:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,397,1557212400"; 
   d="scan'208";a="162414210"
Received: from waelreed-mobl1.ger.corp.intel.com (HELO kekkonen.fi.intel.com) ([10.252.63.228])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jun 2019 09:17:25 -0700
Received: by kekkonen.fi.intel.com (Postfix, from userid 1000)
        id 42E1521D88; Thu, 20 Jun 2019 19:17:22 +0300 (EEST)
Date:   Thu, 20 Jun 2019 19:17:22 +0300
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Hugues Fruchet <hugues.fruchet@st.com>
Cc:     Alexandre Torgue <alexandre.torgue@st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Philippe CORNU <philippe.cornu@st.com>,
        Mickael GUENE <mickael.guene@st.com>
Subject: Re: [PATCH v2 0/3] DCMI bridge support
Message-ID: <20190620161721.h3wn4nibomrvriw4@kekkonen.localdomain>
References: <1560242912-17138-1-git-send-email-hugues.fruchet@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1560242912-17138-1-git-send-email-hugues.fruchet@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugues,

On Tue, Jun 11, 2019 at 10:48:29AM +0200, Hugues Fruchet wrote:
> This patch serie allows to connect non-parallel camera sensor to
> DCMI thanks to a bridge connected in between such as STMIPID02 [1].
> 
> Media controller support is introduced first, then support of
> several sub-devices within pipeline with dynamic linking
> between them.
> In order to keep backward compatibility with applications
> relying on V4L2 interface only, format set on video node
> is propagated to all sub-devices connected to camera interface.
> 
> [1] https://www.spinics.net/lists/devicetree/msg278002.html

General notes on the set, not related to any single patch:

- Where's the sub-device representing the bridge itself?

- As the driver becomes MC-centric, crop configuration takes place through
  V4L2 sub-device interface, not through the video device node.

- Same goes for accessing sensor configuration: it does not take place
  through video node but through the sub-device nodes.

-- 
Kind regards,

Sakari Ailus
sakari.ailus@linux.intel.com
