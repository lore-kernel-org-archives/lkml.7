Return-Path: <SRS0=PjNn=RI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C757EC43381
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:25:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C7120684
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Mar 2019 01:25:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfCEBZY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 20:25:24 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33358 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCEBZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 20:25:24 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1h0ype-00062h-01; Tue, 05 Mar 2019 01:25:22 +0000
Date:   Tue, 5 Mar 2019 01:25:21 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hou Tao <houtao1@huawei.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Benjamin LaHaise <bcrl@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] aio: take an extra file reference before call vfs_poll()
Message-ID: <20190305012521.GU2217@ZenIV.linux.org.uk>
References: <20190225090332.88640-1-houtao1@huawei.com>
 <b9976295-0324-dd98-2546-c8de6ff70a43@huawei.com>
 <978dc206-d28e-fb5d-e857-8d16e160a87c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <978dc206-d28e-fb5d-e857-8d16e160a87c@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 05, 2019 at 09:17:07AM +0800, Hou Tao wrote:
> ping ?

Oh, hell...  I really wish I'd seen your mail back then ;-/
Would've avoided a lot of headache now (and essentially
duplicating your analysis + patch when a later report
got noticed - right before the -final, Murphy Law being what
it is).

Unfortunately, that approach (and I'd ended up with pretty
much the same patch) doesn't solve all problems in the
area; I think I have a sane fix, will post tomorrow morning...

Again, my apologies.  I probably need to do what Linus had
done years ago and unsubscribe from l-k - the traffic is
too high and stuff gets lost in the noise ;-/
