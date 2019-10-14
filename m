Return-Path: <SRS0=TxL2=YH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0688C4CECE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C26520650
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Oct 2019 08:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbfJNIiD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Oct 2019 04:38:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730439AbfJNIiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Oct 2019 04:38:03 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C5F6373A60
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 08:38:02 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id p8so3887082wrj.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2019 01:38:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+0+jYoRl9oEFQs2yc70KUPcvIdquCCUud08IyDTa0Sk=;
        b=KZ5IvvhkD0wIA7uoRIgl1yvtVQQBHSEetv5+pHzhfFp0JX1soki/R50hoz+pfyAb/x
         jp2+nH7LYtlBl3ntm78AD+r9cN3G2uYF16zBN4tRRjwoTea8zHKdZMjBl2ua5Ykur1RX
         QqFVMWAVH8lDQ/kS21DNeWA6whCAg20az9eDszKewu1tZkukGCMk4NzRc+9dh3D4OFcq
         b61A7dzFdABMTepnr4jSBK2z1xAsqleedm0L1LPwnSwgVz1aLg1Z/PmEjfpmOf8UarIW
         0hp+G9+8rgoGijLmGJTcibzO6nqruR8W16J7cbII/iq/ohpgJWA/L/6pJDoA50rpuxCc
         BM2Q==
X-Gm-Message-State: APjAAAWU/E6m2oN+knA2sYSVsxcFy/DYXst2n+0n7lmBSU6NOD+v0kTY
        c/y+Z4huOZ3AgYkK5gRwrJZAeeR7ykFVbtZZd4VQCpgsWwEDPI76CLcuVlqsSlsZbVlco9CA/dw
        hHEue1S6H3xE+LCLDPuolApe0
X-Received: by 2002:adf:ef83:: with SMTP id d3mr24269920wro.398.1571042281413;
        Mon, 14 Oct 2019 01:38:01 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx1Z5KT0VRMmx0ICRJQ57vVQt4XOO7A3AyHOiVUdwcd70YI9rxvp4vdD5PKGwKw9pM+rhgrew==
X-Received: by 2002:adf:ef83:: with SMTP id d3mr24269904wro.398.1571042281249;
        Mon, 14 Oct 2019 01:38:01 -0700 (PDT)
Received: from [192.168.1.81] (host81-157-241-145.range81-157.btcentralplus.com. [81.157.241.145])
        by smtp.gmail.com with ESMTPSA id x5sm22878762wrt.75.2019.10.14.01.37.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 01:38:00 -0700 (PDT)
Subject: Re: [RFC v4 00/18] objtool: Add support for arm64
To:     Raphael Gault <raphael.gault@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com
Cc:     peterz@infradead.org, catalin.marinas@arm.com, will.deacon@arm.com,
        julien.thierry.kdev@gmail.com, raph.gault+kdev@gmail.com,
        mark.rutland@arm.com
References: <20190816122403.14994-1-raphael.gault@arm.com>
From:   Julien Thierry <jthierry@redhat.com>
Message-ID: <f4fd76e1-ae15-3796-77a3-102ccc1ee028@redhat.com>
Date:   Mon, 14 Oct 2019 09:37:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20190816122403.14994-1-raphael.gault@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On 8/16/19 1:23 PM, Raphael Gault wrote:
> Hi,
> 

[...]

> As of now, objtool only supports the x86_64 architecture but the
> groundwork has already been done in order to add support for other
> architectures without too much effort.
> 
> This series of patches adds support for the arm64 architecture
> based on the Armv8.5 Architecture Reference Manual.
> 

I was wondering about the current status of these patches. Is anyone 
actively working on this?

If not, I can pick that up and try to make this go forward.

Cheers,

-- 
Julien Thierry
