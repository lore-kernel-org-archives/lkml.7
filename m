Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C45BFA372C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11F0E207FA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 12:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573214431;
	bh=XJkOJnmVzzu1WF4iJ88czizyhtISED7rDbwYuR6TvZU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v9GiajoH69+RbUcZ6o3TXTMdc3KTEwVDsB9qvDJ3vhf+QdhIv2UeYiQ3N7hguTVth
	 5uiU6bG3dV/bz+jYojuuEEaLm6EBxPR0MkrhDwW8YglhIlKx5Zu7v9xi9oUWvQDpsA
	 9qQltDiKjx8Rxro6kfhMA1jcF4heeepJ2xlPpZ+s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389129AbfKHMA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Nov 2019 07:00:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:49588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387999AbfKHMA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Nov 2019 07:00:27 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F1262207FA;
        Fri,  8 Nov 2019 12:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573214427;
        bh=XJkOJnmVzzu1WF4iJ88czizyhtISED7rDbwYuR6TvZU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i49W6rhXXlR3HhamWhhUZcqfI602+zidDSeIgJasb8YLAgymiEEenGgv5XJWn3lpX
         cvgkKn2T6v2Qnf62hWbUnnmm+lAsrXa2W7cUZvCc2RjV9PtresLozTntziGK2t9NiQ
         llEv/z2UtN3QJDSc1fvAn0nHojYUxZZR68wTCuyg=
Date:   Fri, 8 Nov 2019 07:00:25 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     Julian Wiedmann <jwi@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 4.19 204/205] s390/qeth: limit csum offload
 erratum to L3 devices
Message-ID: <20191108120025.GM4787@sasha-vm>
References: <20191108113752.12502-1-sashal@kernel.org>
 <20191108113752.12502-204-sashal@kernel.org>
 <2e4553d6-de1f-bb61-33e4-10a5c23f0aa7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <2e4553d6-de1f-bb61-33e4-10a5c23f0aa7@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 08, 2019 at 12:50:24PM +0100, Julian Wiedmann wrote:
>On 08.11.19 12:37, Sasha Levin wrote:
>> From: Julian Wiedmann <jwi@linux.ibm.com>
>>
>> [ Upstream commit f231dc9dbd789b0f98a15941e3cebedb4ad72ad5 ]
>>
>> Combined L3+L4 csum offload is only required for some L3 HW. So for
>> L2 devices, don't offload the IP header csum calculation.
>>
>
>NACK, this has no relevance for stable.

Sure, I'll drop it.

Do you have an idea why the centos and ubuntu folks might have
backported this commit into their kernels?

-- 
Thanks,
Sasha
