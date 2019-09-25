Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23FAC432C2
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 12:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F31C20673
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 12:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405613AbfIYMcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 08:32:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53718 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405486AbfIYMcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 08:32:08 -0400
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5129299C48
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 12:32:08 +0000 (UTC)
Received: by mail-wr1-f70.google.com with SMTP id t11so2297797wro.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2019 05:32:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kyLMJ3IhBQ/KpFze3QzLZB6SEbGnQdB46N0jJl2qPwg=;
        b=Ry35BblZd3n38amrYS8NmEdp0YSc6CL4jCY0KCpDyc0EBCku+ZVmYXxhepIg/HGEgF
         q3s0p1Z1XSvIyF3lWYHeQbLH+QTW3CksuuCsUXzcaV4YSmaCS2Pj+pWN6cJshqnDw8zP
         Y0+8lzfAqCFJ4pkwylOuRpmsxv/J1Y+4dVdlXsP8kgrc2EbTEeLqvZCrpdXvnuinUt3+
         Sxy6tg6PZMUaTPmBhGc4fIDEJbvsh1hvMhHfTDhYR1CBvWS2PXcjVETHl5IcmmibXQDQ
         ciUHAXy1ZnC5oPCSUOtK26iOAHEnVSiyaQ+MMrXneyZ86t+7kbTmyJgYdEtLyp7kM8++
         /1Vw==
X-Gm-Message-State: APjAAAXdFSH/6LIBMSMM/q2/IXg0O762XopqcjF/7s9aDp/eaWFW489v
        sbkVuW5jfclHWB053uiyWBNm3FK8eYUsW95Iy5XI6CMrWOYZvcN0xJmY8BLiG26HlpXHM3oeaKL
        OHT5Ok6e4L6rg40al7MAlZ609
X-Received: by 2002:a7b:ce0a:: with SMTP id m10mr7859787wmc.167.1569414726841;
        Wed, 25 Sep 2019 05:32:06 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwKjlR2ia1Y9ZKlmqsbyOzcgRtrJABz/Vgz4TcIr3R6RRJx/MZeMRO0KhB+sAIvQka1CSaz2Q==
X-Received: by 2002:a7b:ce0a:: with SMTP id m10mr7859752wmc.167.1569414726561;
        Wed, 25 Sep 2019 05:32:06 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id d4sm3814633wrq.22.2019.09.25.05.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2019 05:32:05 -0700 (PDT)
Subject: Re: [PATCH 07/17] KVM: monolithic: x86: adjust the section prefixes
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190920212509.2578-1-aarcange@redhat.com>
 <20190920212509.2578-8-aarcange@redhat.com>
 <2171e409-487f-6408-e037-3abc0b9aa312@redhat.com>
 <20190925121330.GA13637@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <d621c8d7-ffc0-5d92-eacc-5af2d296b810@redhat.com>
Date:   Wed, 25 Sep 2019 14:32:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925121330.GA13637@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/19 14:13, Andrea Arcangeli wrote:
> 
> The __exit removed from unsetup is because kvm_arch_hardware_unsetup
> is called by kvm_init, so unless somehow kvm_init can go in the exit
> section and be dropped too during the final kernel link (which would
> prevent KVM to initialize in the first place at kernel boot), it's not
> feasible to call a function located in the exit section and dropped
> during the kernel link from there.
> 
> As far as I can tell with upstream KVM if you hit the
> kvm_arch_hardware_unsetup function during kvm_init error path it'll
> crash the kernel at boot because of it.
> 
> Removing __exit fixes that potential upstream crash and upstream bug.

You're right.

> The comment header was short, I'll add more commentary to the commit
> header to reduce the confusion about why removing __exit is needed.

Yes, thanks!

Paolo
