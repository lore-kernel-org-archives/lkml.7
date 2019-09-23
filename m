Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D00C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86AA220820
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 10:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439375AbfIWKP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 06:15:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44530 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407627AbfIWKP1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 06:15:27 -0400
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 192CA3C919
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 10:15:27 +0000 (UTC)
Received: by mail-wm1-f71.google.com with SMTP id s25so4777685wmh.1
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2019 03:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bK9h7pTx1XY/RyobhLerD+nYvs7a3zb9XOPbV/JaXjc=;
        b=EWEk8ylOYs0+W3SbLOsEMx2fbesfaextc1XPrgjtOEH3fYA7nQer5Pl471LXS/ME5G
         CykVJ2bqn/Qh9n0ijgTkbywV6GkYwTRiJizgZfNtBLAtD1Cm4qh3PBJqbYl2EjlqzSR0
         D/Ac/zQ3NnAS41rQDKKD8l7MCdfTRC3I5BhAuQisQ2pTBfYxDYTebPuRxJhUVaFBqQQC
         EOGTl7NGa+i1R9ZA8/0A2Z1i3QeJyON654iv9nWxvh4wgs+Rs25NdjM7KB8BhPgBSwKE
         DSqVQharddc0Ig7hN1nt6+CC50nPXpI/dc2BUAf94Vl/yALsIgzTxXLts3g2GftKWIX3
         wkBA==
X-Gm-Message-State: APjAAAVRju7dopA1d+OWwpnZviv5L6ARX+/lyo9xax3yu/cUQ+7+3dOY
        7dbc6BoPWlj6BPPcPM2PxV4GkyvKZAKLmcrZAmXrPopT8o0zu0RSTYrbHnSereDLNWr4JLyxGqB
        qZcIPrQtyyvOsM9lVr2hWFfHQ
X-Received: by 2002:a1c:7409:: with SMTP id p9mr12906730wmc.162.1569233725615;
        Mon, 23 Sep 2019 03:15:25 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyz4lp9WKEtONZnQggsXsYyKnvfZ2mN5QVqBU+LVkeipi/oOtTdC4E2TBrDZ/yu4WyQdKl6Cg==
X-Received: by 2002:a1c:7409:: with SMTP id p9mr12906710wmc.162.1569233725398;
        Mon, 23 Sep 2019 03:15:25 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36? ([2001:b07:6468:f312:9520:22e6:6416:5c36])
        by smtp.gmail.com with ESMTPSA id 189sm22794912wma.6.2019.09.23.03.15.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 03:15:24 -0700 (PDT)
Subject: Re: [PATCH 07/17] KVM: monolithic: x86: adjust the section prefixes
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190920212509.2578-1-aarcange@redhat.com>
 <20190920212509.2578-8-aarcange@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <2171e409-487f-6408-e037-3abc0b9aa312@redhat.com>
Date:   Mon, 23 Sep 2019 12:15:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920212509.2578-8-aarcange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/09/19 23:24, Andrea Arcangeli wrote:
> Adjusts the section prefixes of some KVM common code function because
> with the monolithic methods the section checker can now do a more
> accurate analysis at build time and this allows to build without
> CONFIG_SECTION_MISMATCH_WARN_ONLY=n.
> 
> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>

I think it's the opposite---the checker is detecting *missing* section
prefixes, for example vmx_exit, kvm_exit, kvm_arch_hardware_unsetup etc.
could be marked __exit.

Paolo
