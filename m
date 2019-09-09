Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBF4C4360D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 02:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84FCB20578
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 02:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733060AbfIICaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 22:30:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41970 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732560AbfIICaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 22:30:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 278F160ACF;
        Mon,  9 Sep 2019 02:30:55 +0000 (UTC)
Received: from [10.72.12.61] (ovpn-12-61.pek2.redhat.com [10.72.12.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B5E560166;
        Mon,  9 Sep 2019 02:30:24 +0000 (UTC)
Subject: Re: [PATCH 2/2] vhost: re-introducing metadata acceleration through
 kernel virtual address
From:   Jason Wang <jasowang@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jgg@mellanox.com, aarcange@redhat.com, jglisse@redhat.com,
        linux-mm@kvack.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Miller <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org
References: <20190905122736.19768-1-jasowang@redhat.com>
 <20190905122736.19768-3-jasowang@redhat.com>
 <20190908063618-mutt-send-email-mst@kernel.org>
 <1cb5aa8d-6213-5fce-5a77-fcada572c882@redhat.com>
Message-ID: <868bfaed-ede4-6da8-0247-af2a03ea121d@redhat.com>
Date:   Mon, 9 Sep 2019 10:30:20 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1cb5aa8d-6213-5fce-5a77-fcada572c882@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 09 Sep 2019 02:30:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2019/9/9 上午10:18, Jason Wang wrote:
>>>
>>> On a elder CPU Sandy Bridge without SMAP support. TX PPS doesn't see
>>> any difference.
>> Why is not Kaby Lake with SMAP off the same as Sandy Bridge?
>
>
> I don't know, I guess it was because the atomic is l 


Sorry, I meant atomic costs less for Kaby Lake.

Thanks


