Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91451C73C6D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 699C120651
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 05:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfGJFlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 01:41:16 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43658 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726961AbfGJFlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 01:41:16 -0400
Received: by mail-ed1-f67.google.com with SMTP id e3so708786edr.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jul 2019 22:41:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OY11rmPpSH+D8B6VvScwEBe1DCnbT7zlyAqSZqOZeb0=;
        b=oJO5MhM1khD9FjV6HFJrEoLvlAgElO05FDSqhIui2khQa1UxIgL8OIdq1Bw70WQhSM
         y/sFhuj9CIx8rEZB+WgX4cLQCb3mlZLZNo7odw6GVciNFAlQw6QhO7Rtm0lDGBBT4IC7
         9MUUJ0FY4N45S3SD0P0UIR4xGu4oQcjGR+39nfUZL7w3b4CJ+bWt0tSZ6BIZbM5Mj1/6
         a4nxj5rbDOriKD1Yq7vw/LduTBBB1OaxtVW25QU6/lLt9/Zvzq61hFT6SIKicJ8kOHRx
         QDAhPTMxs0GMStb52EKFvDfaSNY+Y2Tt2gfKaMaG11lvoGoPn3ScgFCHhvCNs2CNBcch
         hoZQ==
X-Gm-Message-State: APjAAAVheX8+T/+J4Ejiyw+AQ7CivEmROVpTGEYxKw5QJ5p0HKLPajac
        YUje7hwyOehn8lVJnTxNrSxK5pOsXIw=
X-Google-Smtp-Source: APXvYqxF0wyLFpJaD+4S490iaEEB7HCOq+xZWNx1hKV86gZ/6GN/YPQ1vMZ1zyd7tQmKqhL2DF4Ixg==
X-Received: by 2002:a50:91e5:: with SMTP id h34mr28907927eda.72.1562737274869;
        Tue, 09 Jul 2019 22:41:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:19db:ad53:90ea:9423? ([2001:b07:6468:f312:19db:ad53:90ea:9423])
        by smtp.gmail.com with ESMTPSA id g11sm893689wru.24.2019.07.09.22.41.13
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jul 2019 22:41:14 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] Documentation: virtual: convert .txt to .rst
To:     Luke Nowakowski-Krijger <lnowakow@eng.ucsd.edu>,
        linux-kernel-mentees@lists.linuxfoundation.org
Cc:     rkrcmar@redhat.com, corbet@lwn.net, kvm@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190709200721.16991-1-lnowakow@neg.ucsd.edu>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8b24581c-427f-847a-7f77-2b3fc5c5334e@redhat.com>
Date:   Wed, 10 Jul 2019 07:41:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190709200721.16991-1-lnowakow@neg.ucsd.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/19 22:07, Luke Nowakowski-Krijger wrote:
> After confirming with the appropriate lists that all the
> Documentation/virtual/* files are not obsolete I will continue
> converting the rest of the .txt files to .rst.

There is no obsolete information in Documentation/virtual/kvm.  Thanks
for this work!

Paolo
