Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0393CC2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:19:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCE22212F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 12:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbfFGMTY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 08:19:24 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39158 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbfFGMTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 08:19:23 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so1703996wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2019 05:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kfSHj8gE2BZ00d/KvgMT+jG4F0VNY8qmbsimYDTPJmw=;
        b=qze9HjMcX+XbBs/POnmyrNvQVLJIrB4818uejq1V4AaZE6ZenGVVTCWbMzGgeHbpnr
         uiZt1cao6MFk9cnV83cpaCktR49wdI86tu4ZP7cH8Rny4W93p6itkX7SHc8ZnkKGIxeF
         Hfek8K6L0GKReAJkpM4EKAKJO7FsVEJhntCbr6xcM/1lteHTrQ1W+lE8GQDeh2lJ9ksf
         j+y6/lghxBmLdVhZBg0BBN9U3s15piyS1rQm1VLw/62lk7mjVve9YvFw6OAHI0TF3uvC
         VrE8YSCG9xiZUKwapGGhcpEHvGT4imIZ8wxSZwgtTAaNMV/02txzb0ME7gbbphlPM85j
         kdtg==
X-Gm-Message-State: APjAAAW9nH7hvZlOgt3VQF8B+Wxp7hq/FEl22Xv8uK4OMIjxF8tXY3dT
        P1/ROskyTUy3IaZ5UCBEAECWirnhbzo=
X-Google-Smtp-Source: APXvYqySOcFxw2kk9lDHDgMzNCwDwUWD5eY/j8mlb+Yty+9tmvopHn57wdfq/dhziB9fNrAY3xELaw==
X-Received: by 2002:a1c:df46:: with SMTP id w67mr3344706wmg.69.1559909962473;
        Fri, 07 Jun 2019 05:19:22 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:657f:501:149f:5617? ([2001:b07:6468:f312:657f:501:149f:5617])
        by smtp.gmail.com with ESMTPSA id s11sm1559025wro.17.2019.06.07.05.19.21
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 05:19:21 -0700 (PDT)
Subject: Re: [PATCH] KVM: nVMX: Rename prepare_vmcs02_*_full to
 prepare_vmcs02_*_extra
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <1559834652-105872-1-git-send-email-pbonzini@redhat.com>
 <20190606184117.GJ23169@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8382fd94-aed1-51b4-007e-7579a0f35ece@redhat.com>
Date:   Fri, 7 Jun 2019 14:19:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190606184117.GJ23169@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/06/19 20:41, Sean Christopherson wrote:
>> +static void prepare_vmcs02_early_extra(struct vcpu_vmx *vmx,
> Or maybe 'uncommon', 'rare' or 'ext'?  I don't I particularly love any of
> the names, but they're all better than 'full'.

I thought 'ext' was short for 'extra'? :)

Paolo
