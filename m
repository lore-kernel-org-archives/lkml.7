Return-Path: <SRS0=vtn1=VX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8591EC7618B
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B7C2173E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jul 2019 08:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564128665;
	bh=4sLvy7OTetUBbRmIDYxkokYDFVqwvBVdiW2QB57fytk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TYW52BRrlEHVVIr2IlAywGuF3zl12YLWYVkC4837I+rQ1a8KMN8PmXWUT94J6BALh
	 jbKI0ZelIVj5l0f/7IVSKCOEkmFhq921ymZ5fYsd+rabpGWew0NROAEfgdGqQNf4uq
	 z45aevQSxM9sjEJjuBDVoXe0tSFjAULbpmlkExS4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726279AbfGZILE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jul 2019 04:11:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:36054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbfGZILE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jul 2019 04:11:04 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A64192173E;
        Fri, 26 Jul 2019 08:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564128663;
        bh=4sLvy7OTetUBbRmIDYxkokYDFVqwvBVdiW2QB57fytk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MH/oHJyBXMQCAdPOwG5VY7QwP4/tZrHkTR5fAgyjBh+t2asMKBuqesS/L8z/lIIZn
         s1M6DVvoFtoGfxTy7Ph1RJ30RTsD0z14qAEvZHWRa9NNccXxc2TsXd6a3zWl22gj74
         kqWhn4vBoird+odQE56Z6pJ7+OdFqFUU0/6b4Xb0=
Date:   Fri, 26 Jul 2019 10:11:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Je Yen Tam <je.yen.tam@ni.com>
Cc:     "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH v6] serial/8250: Add support for NI-Serial
 PXI/PXIe+485 devices
Message-ID: <20190726081100.GA28685@kroah.com>
References: <20190726072226.6357-1-je.yen.tam@ni.com>
 <20190726072811.GA3073@kroah.com>
 <MN2PR04MB5920C0F55BE23BB4172F628EB7C00@MN2PR04MB5920.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MN2PR04MB5920C0F55BE23BB4172F628EB7C00@MN2PR04MB5920.namprd04.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 26, 2019 at 07:33:28AM +0000, Je Yen Tam wrote:
> > Subject: [EXTERNAL] Re: [PATCH v6] serial/8250: Add support for NI-Serial
> > PXI/PXIe+485 devices
> > 
> > On Fri, Jul 26, 2019 at 03:22:26PM +0800, jeyentam wrote:
> > > Add support for NI-Serial PXIe-RS232, PXI-RS485 and PXIe-RS485 devices.
> > >
> > > Signed-off-by: Je Yen Tam <je.yen.tam@ni.com>
> > 
> > "From:" name does not match the Signed-off-by: name :(
> 
> Change it in v7?
> 

Please do.
