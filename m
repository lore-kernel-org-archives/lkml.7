Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD53C10F13
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03CD8217D4
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 07:57:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbfDKH5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 03:57:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56968 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfDKH5A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 03:57:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4631A30058D4;
        Thu, 11 Apr 2019 07:57:00 +0000 (UTC)
Received: from [10.72.12.119] (ovpn-12-119.pek2.redhat.com [10.72.12.119])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1783D608A5;
        Thu, 11 Apr 2019 07:56:57 +0000 (UTC)
Subject: Re: linux-next: Fixes tag needs some work in the net tree
To:     David Miller <davem@davemloft.net>
Cc:     sfr@canb.auug.org.au, netdev@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190411165859.63be9174@canb.auug.org.au>
 <722cf76e-a092-5760-8224-c4e62bec3d12@redhat.com>
 <20190411.003732.1589636271559950106.davem@davemloft.net>
From:   Jason Wang <jasowang@redhat.com>
Message-ID: <85336b25-8ed7-2fe8-4efb-b227c8a392ba@redhat.com>
Date:   Thu, 11 Apr 2019 15:56:56 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190411.003732.1589636271559950106.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Thu, 11 Apr 2019 07:57:00 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/4/11 下午3:37, David Miller wrote:
> From: Jason Wang <jasowang@redhat.com>
> Date: Thu, 11 Apr 2019 15:24:59 +0800
>
>> My bad, need I respin or just leave it as is this time?
> You can't fix it if it's already in my tree.


I see. Thanks

