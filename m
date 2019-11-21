Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C32C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B624A2089F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 08:49:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfKUItk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Nov 2019 03:49:40 -0500
Received: from www62.your-server.de ([213.133.104.62]:34272 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbfKUItk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Nov 2019 03:49:40 -0500
Received: from [2a02:1205:507e:bf80:bef8:7f66:49c8:72e5] (helo=localhost)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1iXi9f-0002It-P2; Thu, 21 Nov 2019 09:49:35 +0100
Date:   Thu, 21 Nov 2019 09:49:35 +0100
From:   Daniel Borkmann <daniel@iogearbox.net>
To:     =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn.topel@intel.com>
Cc:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Magnus Karlsson <magnus.karlsson@intel.com>,
        Jonathan Lemon <jonathan.lemon@gmail.com>,
        bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH] xsk: fix xsk_poll()'s return type
Message-ID: <20191121084935.GB31576@pc-11.home>
References: <20191120001042.30830-1-luc.vanoostenryck@gmail.com>
 <103f550e-4a78-e540-4a57-bdecc2f066cf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <103f550e-4a78-e540-4a57-bdecc2f066cf@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.101.4/25639/Wed Nov 20 11:02:53 2019)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 07:15:42AM +0100, Björn Töpel wrote:
> On 2019-11-20 01:10, Luc Van Oostenryck wrote:
> > xsk_poll() is defined as returning 'unsigned int' but the
> > .poll method is declared as returning '__poll_t', a bitwise type.
> > 
> > Fix this by using the proper return type and using the EPOLL
> > constants instead of the POLL ones, as required for __poll_t.
> 
> Thanks for the cleanup!
> 
> Acked-by: Björn Töpel <bjorn.topel@intel.com>
> 
> Daniel/Alexei: This should go through bpf-next.

Done, applied, thanks!
