Return-Path: <SRS0=SA5R=SA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E36C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BB221871
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Mar 2019 03:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hddkAcav"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728707AbfC2DSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 23:18:54 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41106 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbfC2DSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 23:18:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:
        Subject:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=b+Popx9VstVkPBNs9VyMQ0k0yNtMN1cHS0ZFhApTbxA=; b=hddkAcavIvUzzD5zOufBQ8T6M
        akECsGSPyOH4dPdHF96/w4ZtjtUN4DRmykaYwpdnGxI99ZsoU7Nd6edcXD0I0IO6rzTDkHORNKGcz
        4RwVP4C9HamA0nAB8pN0RKos3caENRErtEeYx9UB6sHAAAxM3hdoFV11kd26IfaHkJmkkki4s1HEm
        yavSs158DFIAgqrdP86en4wZj9kyXeIgEsfhhdL1ysFVIDKlndu+IOSWbRSTAEr/84pFtns/mFwt5
        JWhUCm9SrWw9zPs9r/DfzTQRegetyoI88TS3SeJ7YCCxOcjqgs5u3vBhC6FRG0Q1+ICfUc1XD7oRf
        3fCD/YaIQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1h9i2d-0001rU-Bz; Fri, 29 Mar 2019 03:18:51 +0000
Subject: Re: mmotm 2019-03-28-15-50 uploaded (gcov)
To:     akpm@linux-foundation.org, broonie@kernel.org, mhocko@suse.cz,
        sfr@canb.auug.org.au, linux-next@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
        Greg Hackmann <ghackmann@android.com>
References: <20190328225107.ULwYw%akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <f4705506-676e-d331-2a96-5f6f5b00f604@infradead.org>
Date:   Thu, 28 Mar 2019 20:18:49 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190328225107.ULwYw%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/19 3:51 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2019-03-28-15-50 has been uploaded to
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



when # CONFIG_MODULES is not set:

  CC      kernel/gcov/gcc_4_7.o
../kernel/gcov/gcc_4_7.c: In function ‘gcov_info_within_module’:
../kernel/gcov/gcc_4_7.c:162:2: error: implicit declaration of function ‘within_module’ [-Werror=implicit-function-declaration]
  return within_module((unsigned long)info, mod);
  ^


-- 
~Randy
