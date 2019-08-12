Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21DE5C31E40
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 23:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF3BD20665
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 23:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565652766;
	bh=3DDmW9kDhr/IwJsR6g2lEp9/cGOWURav+FslWsiK0+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=igLUHjVYGkPFyGVcoLqXAm9CK696qcP4aKU1upfNhEfnga+rXxBq35x/eVHdQPPQj
	 XP+OSRoP9fUnvAHaVdZv3qecG0EV87ysezqVDA6atciC/W018YjcX8VxTDIuI5QOMJ
	 C30FJo1B0dlY0sh6R5BK9n2TpfQyuVW5Tt8NtGCk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbfHLXcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 19:32:45 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44484 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726200AbfHLXcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 19:32:45 -0400
Received: by mail-ot1-f65.google.com with SMTP id b7so115362831otl.11;
        Mon, 12 Aug 2019 16:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D0CFZ1Cw7EwOnNhmZTmtz0RRwtC+nMsalp8emT68oCM=;
        b=cYI8SsS/7Csb9QVa3MwsIlYDs1YMwkPv0w1xRw8/mhMJzIo2enww07Xq/T65Tmp9Sx
         HcY46zyeXsM08CqklfJdNtPKh8ai6KmAbF0DB4/uIDEEJZQM1Tabl1TpWg7Yv4vr9jOH
         fQ/X8xdWTOc05D1em9h1VjwPDv8VeNULC3Xq/MiKWXYpPSCYCrbSj79nRI0GUnfXb5dl
         MHPCefq0QGdEW2OcrBGzP9DNW/61kUze1iubBWwG/0mg6UGrlW7og5gjKFiZTtume5ZM
         9sulW+dMmmbhKu6b3X1dvUZE4DKDIeW8dv6ZRkVN2B6JpDpkGGXxFgoWTPNjWeBvkrlg
         LIdw==
X-Gm-Message-State: APjAAAUCSDVtciZxoPX/KaTg6PRZUpnBp2Lt8uWdM+jpj0OP8S5f4aB7
        +5SW9uhnZC+A6+ao4JKVXQ==
X-Google-Smtp-Source: APXvYqzuSKoAknR+BRDTeNHhcu7ZdP4VSOsBy/9nJOzGbVO3/DHRkj6QLFRtQKk6Nhe72OKs0FOuOQ==
X-Received: by 2002:a02:8663:: with SMTP id e90mr41002015jai.98.1565652763799;
        Mon, 12 Aug 2019 16:32:43 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id d6sm22314934iod.17.2019.08.12.16.32.43
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 12 Aug 2019 16:32:43 -0700 (PDT)
Date:   Mon, 12 Aug 2019 17:32:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yash Shah <yash.shah@sifive.com>
Cc:     davem@davemloft.net, robh+dt@kernel.org, paul.walmsley@sifive.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        mark.rutland@arm.com, palmer@sifive.com, aou@eecs.berkeley.edu,
        nicolas.ferre@microchip.com, ynezz@true.cz,
        sachin.ghadi@sifive.com, Yash Shah <yash.shah@sifive.com>
Subject: Re: [PATCH 1/3] macb: bindings doc: update sifive fu540-c000 binding
Message-ID: <20190812233242.GA21855@bogus>
References: <1563534631-15897-1-git-send-email-yash.shah@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563534631-15897-1-git-send-email-yash.shah@sifive.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jul 2019 16:40:29 +0530, Yash Shah wrote:
> As per the discussion with Nicolas Ferre, rename the compatible property
> to a more appropriate and specific string.
> LINK: https://lkml.org/lkml/2019/7/17/200
> 
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  Documentation/devicetree/bindings/net/macb.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
