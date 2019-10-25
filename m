Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32B9CA9EAF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 00:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE96021D81
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 00:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571962785;
	bh=qeb+RACViZjfla1NOoCoKbMc/synwBpBMGikLRyGhe8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jXYt02v9HUdBYmlF7czXP4W/Vkf7gX5P4AaPdDjwCL/WnyEfNlCCxnz4F3X5WekxG
	 bPXMZj4/R1+mExTm3cENHV4Rzl0vPYlBirVazRh2M0TJzgTQDj02NCIwwL1uvjgJRV
	 rnn/ziNwlzivFutegOASOI+eW2zRY/B2UISXs5ac=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731230AbfJYATo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 20:19:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:33076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729514AbfJYATn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 20:19:43 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 06BB421929;
        Fri, 25 Oct 2019 00:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571962783;
        bh=qeb+RACViZjfla1NOoCoKbMc/synwBpBMGikLRyGhe8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O+qdYz4m2eXzDmke+fcya7AMtL+kYEqJ67POsjO166w1gMwnumAs2fyFdnPBe2Hnv
         1bIOC2Y37sGz5g9YqX+JmfHmBInXQu9sBFduC1jjwyQV1GtJ+sQBHv9IZxVY+iM1fq
         XK5/e8PDMtn4kD4d5vNK75HAi7R5Xj0AZPORRres=
Date:   Fri, 25 Oct 2019 09:19:38 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Jiri Kosina <trivial@kernel.org>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH trivial] nvme-pci: Spelling s/resdicovered/rediscovered/
Message-ID: <20191025001938.GA28602@redsun51.ssa.fujisawa.hgst.com>
References: <20191024152400.30082-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024152400.30082-1-geert+renesas@glider.be>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied to nvme-5.5
