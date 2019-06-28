Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00330C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D38205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 14:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfF1O3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 10:29:02 -0400
Received: from verein.lst.de ([213.95.11.211]:39181 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfF1O3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 10:29:02 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F307F227A81; Fri, 28 Jun 2019 16:28:59 +0200 (CEST)
Date:   Fri, 28 Jun 2019 16:28:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Philip Li <philip.li@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Liu Yiding <yidingx.liu@intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: buildbot status?
Message-ID: <20190628142859.GA4844@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi buildbot maintainers,

lately I usually get no, in some case a few very delayed build bot
results for my repos.  Is this as known issue?
