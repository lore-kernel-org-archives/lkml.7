Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6107AC282CE
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B5B2208E3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 08:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbfDHIkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 04:40:11 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:36803 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfDHIkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 04:40:10 -0400
Received: by mail-wm1-f41.google.com with SMTP id h18so13722468wml.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2019 01:40:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hKkpqh2B+4FPKKA/JOSm5xpbf5fa5revS7Gv1Ib0vcw=;
        b=SiCVEiGZ+rvzEuFs0do49plKsf7fHBXosoACHYBexa/JcreeUdCN3++0V6x67vYsdo
         yAHz3Sxk29IJE7EwDHPVj1Iayh9iDPbLNxVD6rHbQjAPWDxZrapQTdnWqthXfjZFHYSl
         pto8Zz3XbKDR+CeVytoEpwK5K/pw7phurEKdLFbfRyr8vXrELDen6DZUZCGox4UCT507
         7+qJaqCIJt8YzvKEMZBBJOGYlQSkB25+GAvN2lWQhuXVGLdUfhsizWEAgK96anMP9ouT
         EHgVQYfr8pqJggCTt8fjq2ILkDUJ2iGi/spaL7nryU6KbcHTRMK33aY9EaZAH0pkjukz
         7DQg==
X-Gm-Message-State: APjAAAW15b/YQoE1hAWTpxgfVtpcghd03Kdz82JTSgvd5iN/02Mjo6Jm
        wz23xLyPvEEVl2KktFxn8wT1CA==
X-Google-Smtp-Source: APXvYqypBy8MB1PESZaTkdqGXU7GK4/0oVxh3gEPXD0TqcyTllcltmZQG9tffuuL22hmTu2ZA5e1iA==
X-Received: by 2002:a1c:730c:: with SMTP id d12mr17341284wmb.47.1554712808672;
        Mon, 08 Apr 2019 01:40:08 -0700 (PDT)
Received: from t460s.bristot.redhat.com ([193.205.81.200])
        by smtp.gmail.com with ESMTPSA id o2sm24442404wrs.89.2019.04.08.01.40.07
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2019 01:40:08 -0700 (PDT)
Subject: Re: [PATCH V3 1/2] trace,x86: Add external_interrupts to the
 irq_vectors class
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>,
        Clark Williams <williams@redhat.com>, x86@kernel.org
References: <5c3037f244dcab6c8c380a66034e4c10764c024a.1554710696.git.bristot@redhat.com>
Message-ID: <cba4fa6d-fc45-5d68-5ea3-d2bf62fcba80@redhat.com>
Date:   Mon, 8 Apr 2019 10:40:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5c3037f244dcab6c8c380a66034e4c10764c024a.1554710696.git.bristot@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/19 10:14 AM, Daniel Bristot de Oliveira wrote:
> Currently, the irq_vectors is showing the entry and exit events for
> the interrupts of the architecture, but not for external interrupts.

Oops... Sorry... Please, ignore this version...

-- Daniel
