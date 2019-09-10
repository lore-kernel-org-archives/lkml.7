Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D28C4740A
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFCA82089F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 10:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568112423;
	bh=B4ryuYpuwP869/FsPUpTBLPU9Ef2aP8TbFA85aTCYxg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ltOo5+OmNQ7gIoXVBjCfFg/k/tw77DUPV2QItBbebK5MuTix1kkAfQwu3oY9QzhBk
	 jGmQQsTSyZ1m0TprIIROa3+qH2oQVCtOI1PcQI+ofHki+HNXmk1w8NzuKBBUXPvOFT
	 qJuKl9RPVZrfyxZKPu2pAfNhgC2ieBWJUotzUwZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389290AbfIJKrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 06:47:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729337AbfIJKrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 06:47:02 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD6272067B;
        Tue, 10 Sep 2019 10:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568112421;
        bh=B4ryuYpuwP869/FsPUpTBLPU9Ef2aP8TbFA85aTCYxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TFerXfI/g305yqfLGYhTBpJXSMpeJTlLk6prQUI/b2sei8+WyBd9antgU03XZa6lI
         CaWKEaHPNPEzRYh8NuBkZlXvLOzFIheOmDAzNJz/IgNigKFte2U6Urs/2df9hg+gGQ
         deiobsa/Ra54gV/LnS2orCG3dbIuk6zPmDoW7XY8=
Date:   Tue, 10 Sep 2019 06:46:58 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Greg KH <greg@kroah.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH AUTOSEL 5.2 06/12] configfs_register_group() shouldn't be
 (and isn't) called in rmdirable parts
Message-ID: <20190910104658.GF2012@sasha-vm>
References: <20190909154052.30941-1-sashal@kernel.org>
 <20190909154052.30941-6-sashal@kernel.org>
 <20190910060135.GA30753@lst.de>
 <20190910091938.GA5542@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190910091938.GA5542@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2019 at 10:19:38AM +0100, Greg KH wrote:
>On Tue, Sep 10, 2019 at 08:01:35AM +0200, Christoph Hellwig wrote:
>> Please stop selectively backporting parts of random series.  We'll
>> need to the full series from Al in -stable instead.
>
>Yeah, I'll pick this whole series up soon.  Sasha, can you drop this
>from your queues please?

Yup.

--
Thanks,
Sasha
