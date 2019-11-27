Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFC8DC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 23:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A69302070B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 23:45:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qsj7fvhI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfK0Xpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 18:45:31 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:49910 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbfK0Xpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 18:45:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:References:Cc:To:From:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=6Ae0SH75w1m9aU+nYBuK6tJIXgbYW1zryuD5lKGbbEg=; b=Qsj7fvhIVgbdW2la4fC0lhgvY
        Wo/EmrP1yYHewA72zmi/WVzozZvWb8lBeLvyml2xaT9VBDnOxnAGHjtQOGxdzIlOC5qV2ZrqnS+NM
        XAUoLDYXcXJgriGImAKwHgBDiYZzXyac48+ufX83dxkhAlzZxijJteCqXkLhGN32LNCOsKAnFutZW
        J6JDmuuZKrNUvGvKITm+V6dJTbkooW0ztS1A42D/+26BEzcL9QXK0lYrleCHS+aLYRzwi2BIt8XEN
        TWKWq16+LWH7khXTfkKIY5EjuREmJ6NUW9bRgnSySIuUNyUiP4inGBQf9tYZGqKGbxGKhq0jltmVN
        kr5sgfsBQ==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ia6zy-0003tM-SR; Wed, 27 Nov 2019 23:45:30 +0000
Subject: Re: linux-next: Tree for Nov 19 (bpf/btf)
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf@vger.kernel.org,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20191119194658.39af50d0@canb.auug.org.au>
 <ac0b86e4-611b-81d1-ba09-e819218efe3f@infradead.org>
Message-ID: <8fa2ace8-c3a5-7d7d-b867-9f1c70981541@infradead.org>
Date:   Wed, 27 Nov 2019 15:45:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <ac0b86e4-611b-81d1-ba09-e819218efe3f@infradead.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19/19 7:13 AM, Randy Dunlap wrote:
> On 11/19/19 12:46 AM, Stephen Rothwell wrote:
>> Hi all,
>>
>> Changes since 20191118:
>>
> 
> on i386 or x86_64:
> 
> ../kernel/bpf/btf.c:3466:1: error: empty enum is invalid
>  };
>  ^
> 
> when CONFIG_NET is not set/enabled.
> 
> 

Still seeing this on linux-next of 20191127.

-- 
~Randy
Reported-by: Randy Dunlap <rdunlap@infradead.org>
