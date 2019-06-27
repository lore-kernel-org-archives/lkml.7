Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91919C48BD6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E3B42064A
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 08:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfF0IRt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 04:17:49 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33378 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbfF0IRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 04:17:48 -0400
Received: by mail-wm1-f66.google.com with SMTP id h19so6464556wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 01:17:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=RmjFFyBvDQn6Xfu0Q/BuVkvS+UCn+TuhSSD5OUjhRJI=;
        b=Q8OvIxCAwdZ5y28z+ncxJt5db2YlH98XF81P/+iAgocHHOf3nnQ7VwS/BEBB+Qq8cB
         1B+gkH7wgEuSUzPyW3zBm98fTFYNh58h8z741CgAOL1J0unIQanI/bwbDvUCKYRdj4wh
         Dl/x4ECK4SIJodD/cs2VemCONdfRrm5581Z0MULBbCaSQyq3aFlMjSCotg4TWhEt0egW
         otsDPd/4PWnmxXxbNl0fDO/QsHAUaJCTkr47Hymatk/PYNoINDnaInT3PfiX6omCdLbm
         jlMUoe+NT8EMiGq8ld3I7eU8n5l0DI20hIQjmDp035NZDiTo6Bvu7+GfyRPrFYkMJfqC
         3CTA==
X-Gm-Message-State: APjAAAXO0Lx3fq1pFPckMwj6OAYfPRj4h+M8L7s6VzeUonrOscSAF8VC
        7fPzs/mKIgAYr7C7JfQ4fefF3A==
X-Google-Smtp-Source: APXvYqz3R18OS3WEjLZ+sqKqP/ULCckrvtGOJ16Yd4BZO4NaYsCWsUcLjTip7leqUVtkXS2VltM4KA==
X-Received: by 2002:a7b:c3d5:: with SMTP id t21mr2010355wmj.87.1561623466915;
        Thu, 27 Jun 2019 01:17:46 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:41bc:c7e6:75c9:c69f? ([2001:b07:6468:f312:41bc:c7e6:75c9:c69f])
        by smtp.gmail.com with ESMTPSA id i25sm1753308wrc.91.2019.06.27.01.17.45
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 01:17:46 -0700 (PDT)
Subject: Re: [PATCH 0/2] scsi: add support for request batching
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        jejb@linux.ibm.com, linux-scsi@vger.kernel.org, stefanha@redhat.com
References: <20190530112811.3066-1-pbonzini@redhat.com>
 <746ad64a-4047-1597-a0d4-f14f3529cc19@redhat.com>
 <yq1lfxnk8ar.fsf@oracle.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <48c7d581-6ec8-260a-b4ba-217aef516305@redhat.com>
Date:   Thu, 27 Jun 2019 10:17:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <yq1lfxnk8ar.fsf@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/19 05:37, Martin K. Petersen wrote:
>> Ping?  Are there any more objections?
> It's a core change so we'll need some more reviews. I suggest you
> resubmit.

Resubmit exactly the same patches?

Paolo
