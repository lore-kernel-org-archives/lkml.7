Return-Path: <SRS0=uOpN=TO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A3FC04AB4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:34:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B886820879
	for <linux-kernel@archiver.kernel.org>; Tue, 14 May 2019 15:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfENPed (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 May 2019 11:34:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54226 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfENPed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 11:34:33 -0400
Received: by mail-wm1-f66.google.com with SMTP id 198so3363251wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 08:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8GrnAA+dMbE3aqWsuexkoodhKBT8YIQCDPCVk4/0ONU=;
        b=n5NNPOKB4v75Mam64CegVqZbf9Z5L5NTuX/Hdch5oe8H2sWbXdwbA/oucfVs/dYIcV
         vtMJ8qdBKm3Ky0YK4Pc9d5EPw8tl7BHzooJzqMerwbkD3E/ycoTW0Q2JJTJrGYTOHSU5
         acPIl4A4XDZ2XLeGqqVVWBOgQvSWkD9GspiXNNUKT26QY7jU+lsAFXZfWIkvGo1XBj/G
         0e2/WathEFGUzfdr0bB9wqMLs1APmosK3vy4hD0iVXhe6rKQAuIDHfO5t9rqOGrf+6hB
         cLFgYQmto/CxTsWDgh0cnLh2LVNOA1DQNVfBOeBk/AWcMockP+8K1dm9sx3LUPJaXNPG
         1nQg==
X-Gm-Message-State: APjAAAVRHEkA8uhfnCBRdnNAHEzd2iKmTFaxeuokWMLRt+oLhV9VJwOd
        MRN7PDpzs7xY71R8CUWS5+FfAg==
X-Google-Smtp-Source: APXvYqzOyfjfuVw1aAFsWiF9tA0emSNhG599UJWPqNbEpMVozMuZdTdjulYB4nCzy79n6qV3UvxkPA==
X-Received: by 2002:a1c:9c02:: with SMTP id f2mr6399273wme.8.1557848071813;
        Tue, 14 May 2019 08:34:31 -0700 (PDT)
Received: from linux.home (2a01cb05850ddf00045dd60e6368f84b.ipv6.abo.wanadoo.fr. [2a01:cb05:850d:df00:45d:d60e:6368:f84b])
        by smtp.gmail.com with ESMTPSA id d72sm1644080wmd.12.2019.05.14.08.34.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 May 2019 08:34:31 -0700 (PDT)
Date:   Tue, 14 May 2019 17:34:29 +0200
From:   Guillaume Nault <gnault@redhat.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     davem@davemloft.net, paulus@samba.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2] ppp: deflate: Fix possible crash in deflate_init
Message-ID: <20190514153428.GA11430@linux.home>
References: <20190514074300.42588-1-yuehaibing@huawei.com>
 <20190514145532.21932-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514145532.21932-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 14, 2019 at 10:55:32PM +0800, YueHaibing wrote:
> If ppp_deflate fails to register in deflate_init,
> module initialization failed out, however
> ppp_deflate_draft may has been regiestred and not
> unregistered before return.
> 
Thanks!

Acked-by: Guillaume Nault <gnault@redhat.com>
