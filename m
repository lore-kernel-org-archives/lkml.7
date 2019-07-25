Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E8F8C7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7D822BEF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 13:47:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390428AbfGYNr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 09:47:29 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44797 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390316AbfGYNr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 09:47:28 -0400
Received: by mail-wr1-f67.google.com with SMTP id p17so50842386wrf.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2019 06:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SuqKb4YQAqjtnzI980ZUMZ7vCnY7EH5Bjcy9gutNiME=;
        b=ohNmGB+KdtaUc2WPUjLNt0udZq7iwppN9YxLPLgShKah5OHq7K6qtwWiE/8Wh5JvtV
         4LLQAxW8HNL4TL7cu6jBvHFKPWkHkOrxdSBAR0jXh+ikTxaB/rK2/EFZeWs7kmMUQM8y
         f69FUjnZin9OrtcQhAcySV3mmGQ/P8Hvkl3iDQWNQmRyEdoO2byTRG5WIO6dExVCdwBH
         o+sIBbQIpN+DL+1468hnK30OgTzy3F+1vfCIxSyC0yqqTY7ywYZrMsVS/HAVhmOph1sr
         LkbFbZVDlxUtoxVVpDXpS1QoI4VlAVnDwHBjCI8tSe2H0+2MtnwveOCT09dOfVmO3bUi
         b3nA==
X-Gm-Message-State: APjAAAWSeg6pELACt8dsxeHYidE0JbU8SbswTpdoAavj22ih8cnTvVMS
        i8oM6MzBNHUNz9s05XrAyBsc0at4nes=
X-Google-Smtp-Source: APXvYqyVTWbHYVJtfb8PPMD0m6sn37kpY1SzS/gA5xrUjwXvBu+fI5/Qxy5jGVWV/mlkU2TH/UWX8Q==
X-Received: by 2002:adf:e602:: with SMTP id p2mr58047995wrm.306.1564062446855;
        Thu, 25 Jul 2019 06:47:26 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:cc23:f353:392:d2ee? ([2001:b07:6468:f312:cc23:f353:392:d2ee])
        by smtp.gmail.com with ESMTPSA id f12sm54395018wrg.5.2019.07.25.06.47.25
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jul 2019 06:47:26 -0700 (PDT)
Subject: Re: [PATCH 5.2 000/413] 5.2.3-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anders Roxell <anders.roxell@linaro.org>
Cc:     sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org, ben.hutchings@codethink.co.uk,
        stable@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        torvalds@linux-foundation.org, linux@roeck-us.net
References: <20190724191735.096702571@linuxfoundation.org>
 <CADYN=9+WLxhmqX3JNL_s-kWSN97G=8WhD=TF=uAuKecJnKcj_Q@mail.gmail.com>
 <20190725113437.GA27429@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <230a5b34-d23e-8318-0b1f-d23ada7318e0@redhat.com>
Date:   Thu, 25 Jul 2019 15:47:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190725113437.GA27429@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/19 13:34, Greg Kroah-Hartman wrote:
> Any chance you can run 'git bisect' to find the offending patch?  Or
> just try reverting a few, you can ignore the ppc ones, so that only
> leaves you 7 different commits.
> 
> Does this same test pass in 5.3-rc1?

Anders, are you running the same kvm-unit-tests commit that passed for 
5.2.2?  My suspicion is that your previous test didn't have this commit

    commit 95d6d2c3228891537ee8e35d2e2984964ee0cf6b
    Author:     Krish Sadhukhan <krish.sadhukhan@oracle.com>
    AuthorDate: Fri Jun 28 18:14:47 2019 -0400
    Commit:     Paolo Bonzini <pbonzini@redhat.com>
    CommitDate: Thu Jul 11 14:26:53 2019 +0200

    nVMX: Test Host Segment Registers and Descriptor Tables on vmentry of nested guests
    

since the symptoms match and the corresponding fix was made in 5.3.

I think Linaro's tests would be helped by making kvm-unit-tests.git a submodule of
Linux, but I'm a bit wary since it would be the first submodule and I wouldn't know
where to put it...

Paolo
