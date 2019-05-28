Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C277CC04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 06:12:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AE22206C1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 06:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbfE1GMX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 02:12:23 -0400
Received: from verein.lst.de ([213.95.11.211]:45013 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726657AbfE1GMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 02:12:23 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6013868AA6; Tue, 28 May 2019 08:11:59 +0200 (CEST)
Date:   Tue, 28 May 2019 08:11:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sahitya Tummala <stummala@codeaurora.org>
Cc:     Christoph Hellwig <hch@lst.de>, Junxiao Bi <junxiao.bi@oracle.com>,
        Joel Becker <jlbec@evilplan.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] configfs: Fix use-after-free when accessing
 sd->s_dentry
Message-ID: <20190528061159.GA11705@lst.de>
References: <1546514295-24818-1-git-send-email-stummala@codeaurora.org> <20190131032011.GC7308@codeaurora.org> <0081e5c8083f5ed9f1c1e9b456739728@codeaurora.org> <20190517082312.GA13457@lst.de> <20190523034956.GA10043@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523034956.GA10043@codeaurora.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to configfs-for-next.
