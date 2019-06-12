Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99657C31E48
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A3A520B1F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 14:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s0SjHp+6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439585AbfFLOPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 10:15:39 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54316 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407745AbfFLOPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 10:15:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=LeP6TwcOzXjrNratAgB9CTHzJxD6E/7uL3lYkwID07Q=; b=s0SjHp+66yKDoLfqPmmTR9A1x
        xcTi4R2hpEoWWXwekhD5QflpARm+Oj8OycE3A0RX9F5OXU4F+rUF2YQJr+wCY3xpXZUKIBQUn5Cc3
        5jQ/ySl8nFb1AaAQgSLxazJEoPy5Zyh6Yc4p84fmbTTcXaT9RtJcBFUw/F/OpU8oaN0dD/JqWgEmu
        SXjUyP2xKcRyyNx6Uw5TKxSO99+0TFJSHQVUb8Sucrtj5Jd/sjblXbbcUwekshFd4F4N0bq/klJMn
        czCGeNBi6g04ppweLr8qrgGe/gmzQWJ5uvUrbUK9Gdp7wDd+s35xv6RDK1BW2e9jbHipenRJNW7/P
        a5hzYJ3TA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hb42I-00012U-17; Wed, 12 Jun 2019 14:15:34 +0000
Subject: Re: mmotm 2019-06-11-16-59 uploaded (ocfs2)
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>
References: <20190611235956.4FZF6%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <492b4bcc-4760-7cbb-7083-9f22e7ab4b82@infradead.org>
Date:   Wed, 12 Jun 2019 07:15:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190611235956.4FZF6%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/11/19 4:59 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2019-06-11-16-59 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/
> 
> mmotm-readme.txt says
> 
> README for mm-of-the-moment:
> 
> http://www.ozlabs.org/~akpm/mmotm/
> 
> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
> more than once a week.


on i386:

ld: fs/ocfs2/dlmglue.o: in function `ocfs2_dlm_seq_show':
dlmglue.c:(.text+0x46e4): undefined reference to `__udivdi3'


-- 
~Randy
