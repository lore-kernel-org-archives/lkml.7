Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E7CC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 07:55:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B20F720449
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 07:55:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390502AbfHBHzN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 03:55:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37354 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390222AbfHBHzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 03:55:13 -0400
Received: by mail-wr1-f68.google.com with SMTP id n9so51079865wrr.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2019 00:55:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iQeecZfwLuP7CODOolIpmoLPGZENj4z5U1obZlPPBsE=;
        b=TWPCQO7Kbwy54z6Iq7dqGnTc9mNdheKI7Vs2CuJmnQOJhj57ySXvv/S75S2AQtD26U
         +jRgyVyaXaUzfxUkKjSprpw9rlSz25Zp7CCYFySY7frnWlBlxGXUYTHk0X3I7uMixffA
         ohm/lCOJ+o3ervN4JLkXBSlWB1J69hc75RSnhf0SgAkJmOu7Giw73oSaQ1XM++SGlBbN
         KmlG7kar2jwFh7qJs11BDXMkGQFrgGJnsOSnnMW898ROIMLJKCcq4VtUik3T70Os40jr
         czW5JvQHkkX9fqXH/NV8bmhIOwaW9zjAJHVRkuV1ks3dk71YnKf229ZVu+gY66dNe2xA
         jnTg==
X-Gm-Message-State: APjAAAUMc5WzM1OtlR5iwqVXA10o914XZSiAeNZCVpkMMnJj5pjpaWOF
        oeOgT0sp5TTQHSsrIYlSujRmWQ==
X-Google-Smtp-Source: APXvYqxJYMba81q1+ZjYpm8CUmRIMpGHEf3SB8tgLMove58CtJewiAKhbgEp6Gf/LDnWAQBR7N5n+w==
X-Received: by 2002:a05:6000:42:: with SMTP id k2mr23783548wrx.80.1564732511147;
        Fri, 02 Aug 2019 00:55:11 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it. [79.13.201.122])
        by smtp.gmail.com with ESMTPSA id j9sm83739926wrn.81.2019.08.02.00.55.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 02 Aug 2019 00:55:10 -0700 (PDT)
Date:   Fri, 2 Aug 2019 09:55:08 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jorgen Hansen <jhansen@vmware.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/11] VSOCK: add vsock_test test suite
Message-ID: <20190802075508.tumpam2vfmynuhd5@steredhat>
References: <20190801152541.245833-1-sgarzare@redhat.com>
 <PU1P153MB0169B265ECA51CB0AE1212DEBFDE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB0169B265ECA51CB0AE1212DEBFDE0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 04:16:37PM +0000, Dexuan Cui wrote:
> > From: Stefano Garzarella <sgarzare@redhat.com>
> > Sent: Thursday, August 1, 2019 8:26 AM
> > 
> > The vsock_diag.ko module already has a test suite but the core AF_VSOCK
> > functionality has no tests.  This patch series adds several test cases that
> > exercise AF_VSOCK SOCK_STREAM socket semantics (send/recv,
> > connect/accept,
> > half-closed connections, simultaneous connections).
> > 
> > Dexuan: Do you think can be useful to test HyperV?
> 
> Hi Stefano,
> Thanks! This should be useful, though I have to write the Windows host side
> code to use the test program(s). :-)
> 

Oh, yeah, I thought so :-)

Let me know when you'll try to find out if there's a problem.

Thanks,
Stefano
