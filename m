Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35699C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:15:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0993720850
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 19:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553541354;
	bh=M/ygzCPiYkhLch6ElRUVHQjHGAC/dIWRpbO+UTyzGjA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TKJtmAoodaa3QXkeD/lbH12XbKfeO7Nx3k7f7Z99/VDl4jDKqxpdPdGfqPD/AEC+H
	 B6edWuJQ/X0smmyMASrcPT6V16CWNFdUa5oX9IWvLDEXY4YlqWrnsyjpzm63KxYgsx
	 U78TtOA4tqepmIxpaRZbyW3xh5Xes/wAP3kYMuuo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730043AbfCYTPw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 15:15:52 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44976 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYTPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 15:15:51 -0400
Received: by mail-ot1-f65.google.com with SMTP id d24so9097704otl.11;
        Mon, 25 Mar 2019 12:15:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=zPI6QtvMoXfKxAwdG1XFBUMDqBY5TT2JuWxffj41nKM=;
        b=Hy4B3NIFeHnbWXriVKpALwK31Ot0YbBeJh5DLAQQJOVkYFo7Ndclyg6IUZ324GoRld
         Wn9wYT22vG8+edUzyHYcko55yw2ndh9yXrM9h6dT/Rw1ELdKVD7sBOYkbVlq/6nBNGI+
         IxUv/a2EwTPCmeOgAVpc9aLMYWFIicuMJBW2sKlMfaDbc7Iq0nipj1PF//kX1Or1E5nH
         q3K2szHpkm2ShyAaQREePgiIWmOW9WINENb+JeXqyrvj8pnlC7TFh0KUI5VKS87xkkLD
         JN3dJqJajiLwyTrrQeLaje01zNzYbJmUAILtrqsPEmTgG5PO7LxHj4hngbgbhd9ARg94
         iBPA==
X-Gm-Message-State: APjAAAVNMzbndlxqvXt8ODaHhcbX4BPLsiXfJ3vABxzs5kI59yQk5GYV
        aXw8zle4FW8t6lh21zpTVw==
X-Google-Smtp-Source: APXvYqxUn7NCsKsNnOH1bCJPJwvcm8ZE8TjKC/epYHN7P6IH1aLVkxJ7uv3XvJzw2syJMfeRrZc47g==
X-Received: by 2002:a9d:2c28:: with SMTP id f37mr17762309otb.126.1553541350018;
        Mon, 25 Mar 2019 12:15:50 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o83sm5402103oif.33.2019.03.25.12.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 12:15:49 -0700 (PDT)
Date:   Mon, 25 Mar 2019 14:15:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Russell King <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] dt-bindings: display: armada: Improve the LCDC
 documentation
Message-ID: <20190325191548.GA1323@bogus>
References: <20190320082057.856943-1-lkundrak@v3.sk>
 <20190320082057.856943-4-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320082057.856943-4-lkundrak@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 09:20:55AM +0100, Lubomir Rintel wrote:
> The port is a child, not a property. And should be accompanied by an
> example. Plus a pair of cosmetic changes that don't seem to deserve a
> separate commit.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> 
> ---
> Changes since v2:
> - Collected the Reviewed-by tag

Really, where?

> Changes since v1:
> - Minor adjustments to the commit message wording.
> 
>  .../bindings/display/marvell,armada-lcdc.txt     | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
