Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5F3C04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B68B214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 06:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfEHG5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 02:57:43 -0400
Received: from verein.lst.de ([213.95.11.211]:37432 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfEHG5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 02:57:42 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 71A2C68AFE; Wed,  8 May 2019 08:57:23 +0200 (CEST)
Date:   Wed, 8 May 2019 08:57:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     viro@zeniv.linux.org.uk, jlbec@evilplan.org, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] configfs: Fix possible use-after-free in
 configfs_register_group
Message-ID: <20190508065723.GA21298@lst.de>
References: <20190505030312.26548-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505030312.26548-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to the configfs tree.
