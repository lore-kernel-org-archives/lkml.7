Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5F8C10F06
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 107DF20643
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 17:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552324908;
	bh=irusktoUqBxIGna2TUrk+42IOTws/SJm4zdVFovg4U8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=PUWlJE3fuBkwW+yqX5Ir/yKrvq/KgFuLSF+G6tPpmGucVlM3Hnctu250XoNQLOMxz
	 RN3DQarUD6qAHOQX5AFpGzy6GSkcALN59WBo6P5J7oKtozVavJlhk5sEUfiezBFZW8
	 xKoiuobKX3S/eCcq+M8Zr9kzthFbfXeetvVibJLA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfCKRVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 13:21:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:50256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727110AbfCKRVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 13:21:46 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 89D6F2063F;
        Mon, 11 Mar 2019 17:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552324905;
        bh=irusktoUqBxIGna2TUrk+42IOTws/SJm4zdVFovg4U8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ABOXfqh5WHjVkWwB/A4gBhc+9RG16n7B18BhCj4upaBBVv3nb3Y5z9zousty7k9wH
         EWN+z+7sKU6btYhahiq/02QU8QD8+GjvNBfSSu3RgJfEZgGRicSz/SlIcd4vA6ja5D
         PcTtbE55+Fnpe91RPOZ+q8SBadvBStjQiiBSs4wg=
Date:   Mon, 11 Mar 2019 13:21:44 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH AUTOSEL 4.19 59/64] nvme-pci: fix rapid add remove
 sequence
Message-ID: <20190311172144.GF158926@sasha-vm>
References: <20190228151105.11277-1-sashal@kernel.org>
 <20190228151105.11277-59-sashal@kernel.org>
 <20190228151642.GA21796@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190228151642.GA21796@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 08:16:43AM -0700, Keith Busch wrote:
>On Thu, Feb 28, 2019 at 10:11:00AM -0500, Sasha Levin wrote:
>> From: Keith Busch <keith.busch@intel.com>
>>
>> [ Upstream commit 5c959d73dba6495ec01d04c206ee679d61ccb2b0 ]
>
>This patch was broken, so please make sure to include the one that
>fixes this:
>
>  Upstream commit 4726bcf30fad37cc555cd9dcd6c73f2b2668c879
>  ("nvme-pci: add missing unlock for reset error")

I've queued this one as well, thank you.

--
Thanks,
Sasha
