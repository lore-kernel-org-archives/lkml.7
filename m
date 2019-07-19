Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA236C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F1CA2184E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 13:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563543120;
	bh=rJNsY6WFBMfUMhkdZP87ZW6Yf+2uj2nXGax5chzQhC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LBuo2h6NMrVQ83B2N1lBxKkmE4hlT8s70mXEpWPOqCVhn4agg0NiInbRL0QpdBE8k
	 RgR///KrKjiT35uojARG1pP7rOfCehLGSrg42Lu0jbrz6UjuFWpfaOvX/MERKn+RMY
	 60uacXb7kTc+T7EKGYYDJe1FzqF4r0TcpvfYVtN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbfGSNb7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 09:31:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:52836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728996AbfGSNbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 09:31:47 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E594D2184E;
        Fri, 19 Jul 2019 13:31:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563543106;
        bh=rJNsY6WFBMfUMhkdZP87ZW6Yf+2uj2nXGax5chzQhC4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ucoj0coKxe0PGz9qcRNIpLr6jpv6W5s/eNvbRoOGfXNVrwDg+npRcn1U/oMlbuRQc
         dGeJPKdj9Ul7ojYr0Ran7FlT3CB/al6tOxnpRbWBZV4I9nr/JdVcKXB85jS63Nme4a
         A3u46lKf7LGDPJXgSAEBFNrLwXwUL25MhuNulIU4=
Date:   Fri, 19 Jul 2019 09:31:44 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Thierry Reding <treding@nvidia.com>, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.14 41/60] PCI: tegra: Enable Relaxed Ordering
 only for Tegra20 & Tegra30
Message-ID: <20190719133144.GE4240@sasha-vm>
References: <20190719041109.18262-1-sashal@kernel.org>
 <20190719041109.18262-41-sashal@kernel.org>
 <838a6940-2a37-b91b-d522-8b154f3c71d7@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <838a6940-2a37-b91b-d522-8b154f3c71d7@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 19, 2019 at 09:33:11AM +0100, Jon Hunter wrote:
>Hi Lorenzo,
>
>We have not requested that this is added to stable yet, however, has
>been picked up. Do we wish to let it soak in mainline for a release
>first? If so maybe we can ask Sasha to drop this for now.

Note that there are about two weeks between this mail and the point
where it actually appears in a stable tree.

AUTOSEL patches follow a much slower pace than ones marked for stable
exactly for the reason you've mentioned.

--
Thanks,
Sasha
