Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9F4CA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7DFC2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 13:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388703AbfJ2Ng1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 09:36:27 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:40051 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbfJ2Ng1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 09:36:27 -0400
Received: from mail-yw1-f69.google.com ([209.85.161.69])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1iPRfd-0004jR-4Q
        for linux-kernel@vger.kernel.org; Tue, 29 Oct 2019 13:36:25 +0000
Received: by mail-yw1-f69.google.com with SMTP id o130so9797320ywo.17
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 06:36:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rwtNqWivpFIQgbUVsKN05tdEedk/c2ICmFFDz7gAHHg=;
        b=qzpxkmC7InOE3YiM5zc+JDzcAOdAro9n7gSDsi6b7nQaTU1SikSokVUJZJS3xoHNeq
         5IwNxsIdxLDQDqDCKQoF0uwr6qWiNHCn5/hNHBa4prcHKfcaTkcPBmS45tMV6K4H9dPH
         3SLKo487sQWSH342zrsQ6fGnW2B3C77QOx/S0vAgcJZarXUBmekcYde2SQDmpZm+I7oA
         gz2ruguimmEXfSEgX6G8YNYIDyLQbZrAyXLSbvOknc4SdrivizcHvjcTd9mD+XfERY6f
         ie+CwEm5dEMGklR8bcn1By24qV7vSVA+DabFNnjfQRDN42bK+CMjqp3TY2aQYU3Uup8s
         /X0Q==
X-Gm-Message-State: APjAAAUKHTLfSDvcHi/+9rr9QeK8QfF8E/ovwzhwgPDEf68z5CdZ/jGG
        A6ndBk2PTdmfmXfLr+Y1PzFDH/6IaCUzjKPCKMoWFHcup+d8L8jMaJQ0tCJlualulka4ZS/7UqQ
        ybCgqwqRHAV5/wxBa8wPCkYuo7axSJYdn7m29WfeMIQ==
X-Received: by 2002:a81:500a:: with SMTP id e10mr17707255ywb.58.1572356184087;
        Tue, 29 Oct 2019 06:36:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzWRUgkWNbdDnzVotQDun7zMckaFR1TaoB4O5PCly4//oAwUlzOU76kcVYnSSfbVTEjaG0pKg==
X-Received: by 2002:a81:500a:: with SMTP id e10mr17707210ywb.58.1572356183528;
        Tue, 29 Oct 2019 06:36:23 -0700 (PDT)
Received: from localhost ([2605:a601:ac3:9720:f461:b9b9:429:65bd])
        by smtp.gmail.com with ESMTPSA id x201sm17900019ywx.34.2019.10.29.06.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 06:36:22 -0700 (PDT)
Date:   Tue, 29 Oct 2019 08:36:21 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Dmitry Tunin <hanipouspilot@gmail.com>
Cc:     wireless-regdb@lists.infradead.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Russian entry is incorrect. According to the last
 regulations document of Feb 29, 2016, 160 MHz channels and 802.11ad are
 allowed.
Message-ID: <20191029133621.GP30813@ubuntu-xps13>
References: <1566636490-3438-1-git-send-email-hanipouspilot@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1566636490-3438-1-git-send-email-hanipouspilot@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 24, 2019 at 11:48:10AM +0300, Dmitry Tunin wrote:
> http://rfs-rf.ru/upload/medialibrary/c1a/prilozhenie-1-k-resheniyu-gkrch-_-16_36_03.pdf
> 
> Note that there was never a DFS requirement in Russia, but always was
> NO-OUTDOOR on 5GHz.
> Maximum power is 200mW that is ~23dBm on all 5GHz channels.
> Also Russia has never been regulated by ETSI.
> 
> EIRP has been reduced by 4dBm because of TPC requirement.
> 
> Signed-off-by: Dmitry Tunin <hanipouspilot@gmail.com>

Sorry for the delay. Applied, with some slight adjustments to the commit
message. Thanks!
