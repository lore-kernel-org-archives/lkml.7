Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11036C31E43
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AA020820
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 16:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560185290;
	bh=3q0wdBIBloAaKbF30NNBcupNXjug5nIS2FnWZbNAe2g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=plCbuXmKK72ZyK+kQSUlpaC2eBKt8n7cfPdfPUnvCeRYDwa/9no2iHL2wq7uXlmHe
	 6vQtjfxWhWh/7TXhEmnYGsXDnoiDqPiDR9Rx/AKLCYIqKfCcyb49DGE2L5Z4CoJT5e
	 7HhlDMiqwhGZ/5DO1dhjiXhLEFQZu/tmlpelAst0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbfFJQsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 12:48:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:53226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbfFJQsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 12:48:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B062F21721;
        Mon, 10 Jun 2019 16:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560185289;
        bh=3q0wdBIBloAaKbF30NNBcupNXjug5nIS2FnWZbNAe2g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xewsbSbPxHoWDdWHAHP9sZybWLjLS7IliCL/Tc6Tya2fNau5BlSCNVvB6IKoCpTq3
         nE3MNfKlGZxuUduGprJf6rfo062bFn4e5pHJjgqdOPwN4qbdnRNCn0qsBcnFphAAka
         Jj1oP+oNoGSk4SxkQw6qOq0HqoIckotX3VhDXWvc=
Date:   Mon, 10 Jun 2019 18:48:07 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Erwan Le Ray <erwan.leray@st.com>
Cc:     Jiri Slaby <jslaby@suse.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-serial@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        Bich Hemon <bich.hemon@st.com>
Subject: Re: [PATCH 04/10] serial: stm32: add pm_runtime support
Message-ID: <20190610164807.GA25660@kroah.com>
References: <1559638519-6128-1-git-send-email-erwan.leray@st.com>
 <1559638519-6128-5-git-send-email-erwan.leray@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559638519-6128-5-git-send-email-erwan.leray@st.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2019 at 10:55:13AM +0200, Erwan Le Ray wrote:
> Use pm_runtime for clock management.
> 
> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> Signed-off-by: Erwan Le Ray <erwan.leray@st.com>

Does not apply to my tree :(


