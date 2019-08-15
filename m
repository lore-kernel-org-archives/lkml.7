Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 219D9C433FF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 02:12:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBB262067D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 02:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565835151;
	bh=pOrvzN/QLbtBFchgC3sN1CmSrdgqkMHRmubmHw0B1A8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=uzPVtPy9FzSHAol1Fk4RRtMarXEWRX5LIKPXeSpR+9lS/9XiptFFtn1UmF8341Fn1
	 DIq/TNGE4Tav4H8AH+tj0gqJwd+dJwLHgGCNM6qnu8gh6/HKZgj+CL5/LTuB13y4WC
	 ntvT28JYnwQMq+bIVzzL+WP7BYTlVbsungxhysSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729318AbfHOCM3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 22:12:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46025 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbfHOCM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 22:12:29 -0400
Received: by mail-ot1-f65.google.com with SMTP id m24so2714095otp.12;
        Wed, 14 Aug 2019 19:12:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=W4zI/H4zcDMXTffGqKG8VzIoysb2Hk0EiApPxobm/1A=;
        b=P2j8CDdSreSShpOi2SxYvDW0m0yYRLzW1aUweGuxLnJXKlnOJN+0dir+rqUIV8Mrhm
         yBL7gMWpGmFaPk/0tth8nCCMo9Wnt/fuTWrvldkWFBRtk/62pwefbICwVZqMC+XdLIZL
         9QGOajCPytLjtmccfQTpGodKlZ3j+CsAzDxeQr93EtJLn5/pRbdDTYECQVDilhQohIkO
         AdWTRY/zKCo4aAbj0tnt6dIdl6NC5MJR8Ao3TQtXqOxksSN0VjvYve59+NUIaWJdKESa
         g1acDosGJPH9Yb+bsgqUFly14jfqgPEMT6PM0RrZwee7CKKCSNNQ9Q84oZxPPFYynPP3
         ojsA==
X-Gm-Message-State: APjAAAUI5R4AblMko4Evw8alNQlGkOCXZ8rhFeyO+T4v1nYHcgNyWkn2
        IXnbv5xDDLiKtqtLgADmxQ==
X-Google-Smtp-Source: APXvYqwgxcpUPJtS4eSIwquncRcqZ24iDKeF9Vz+TtxUixprXqGbFAsbiJOceimRI3olbzIzQmn8cg==
X-Received: by 2002:a6b:fb10:: with SMTP id h16mr3102066iog.195.1565835148747;
        Wed, 14 Aug 2019 19:12:28 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id m4sm1043493iok.68.2019.08.14.19.12.27
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 19:12:27 -0700 (PDT)
Date:   Wed, 14 Aug 2019 20:12:26 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Jiri Kosina <trivial@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: Re: [PATCH] of: irq: fix a trivial typo in a doc comment
Message-ID: <20190815021226.GA3094@bogus>
References: <20190807132231.10454-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807132231.10454-1-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  7 Aug 2019 15:22:31 +0200, Lubomir Rintel wrote:
> Diverged from what the code does with commit 530210c7814e ("of/irq: Replace
> of_irq with of_phandle_args").
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/of/irq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks.

Rob
