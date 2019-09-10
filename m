Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8C2C49ED6
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80905208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 06:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404597AbfIJGBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 02:01:42 -0400
Received: from verein.lst.de ([213.95.11.211]:56472 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730117AbfIJGBm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 02:01:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3FFFD68B05; Tue, 10 Sep 2019 08:01:36 +0200 (CEST)
Date:   Tue, 10 Sep 2019 08:01:35 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH AUTOSEL 5.2 06/12] configfs_register_group() shouldn't
 be (and isn't) called in rmdirable parts
Message-ID: <20190910060135.GA30753@lst.de>
References: <20190909154052.30941-1-sashal@kernel.org> <20190909154052.30941-6-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909154052.30941-6-sashal@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please stop selectively backporting parts of random series.  We'll
need to the full series from Al in -stable instead.
