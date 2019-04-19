Return-Path: <SRS0=WRlz=SV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06921C282DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:32:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C387420449
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Apr 2019 18:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555698777;
	bh=GXinVPTFuEmYXYXwgge4NIO0K7fZw/O7Xjy8pOV0RQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AcEA/inxdZpY1PrLmWN5WQ8w3PuOVrtvO1HYttfh1b4aG/+pflY3EFLT/QOzdVN2R
	 UpF4Ow/zZYFZyQc9xNVVYCVt65oMg1NWT/fxXORRaG2EYVIhu2SZtqp40wMKeVFKMi
	 WCNexTE8QZ0INIBRDYc6XqRTh3WOHeP3uzQWpGQU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbfDSSc5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:32:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727802AbfDSS3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Apr 2019 14:29:17 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCF8E222B1;
        Fri, 19 Apr 2019 13:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555681146;
        bh=GXinVPTFuEmYXYXwgge4NIO0K7fZw/O7Xjy8pOV0RQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WVA1TsP0FIdVHZYxMUrK10lk0oyzUhIYd7Jmq1lacZNBHq2EQTcB/o9p3r4LfJxur
         H25uXXacDoV+oGxXH8iXOKqeM1Z2NKmu8ektWCQ+JvR1hedWGGy0gEZmxUtoa4ueoS
         sSea37/S+nH3CM1+k2IctiCjLigE1PGzHva/PfJY=
Date:   Fri, 19 Apr 2019 09:39:04 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>, Hulk Robot <hulkci@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 4.14 68/92] appletalk: Fix use-after-free in
 atalk_proc_exit
Message-ID: <20190419133903.GF17719@sasha-vm>
References: <20190418160430.325165109@linuxfoundation.org>
 <20190418160436.162514132@linuxfoundation.org>
 <CADVatmMYbPR2c2937DXHwJDy+Ve4ny47QVJDdbXJR5ftghyS6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CADVatmMYbPR2c2937DXHwJDy+Ve4ny47QVJDdbXJR5ftghyS6w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2019 at 09:14:09PM +0100, Sudip Mukherjee wrote:
>Hi Greg,
>
>On Thu, Apr 18, 2019 at 7:25 PM Greg Kroah-Hartman
><gregkh@linuxfoundation.org> wrote:
>>
>> [ Upstream commit 6377f787aeb945cae7abbb6474798de129e1f3ac ]
>
>This has been fixed by 27da0d2ef998 ("appletalk: Fix compile regression").

I've queued it up, thanks!

--
Thanks,
Sasha
