Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 493DAC10F0B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17DA92082C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="fNKVdLeG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfDCPpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:45:38 -0400
Received: from a9-54.smtp-out.amazonses.com ([54.240.9.54]:58300 "EHLO
        a9-54.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725990AbfDCPpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1554306337;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=Eh1VbaI4wezMKlsjcm5vyrOc3cPM6V0fDLZmVvAIr84=;
        b=fNKVdLeGoDup3EZR/C4+OUJ/1ngF37rhYt3ZVYWZq/X1pIzll+jaBCKskTzvxnYl
        fpEWz9k+s0ALrbAR2XjNoHsVKK/LuTsvclHrUiXraqaOXoB6fsH+IqIFR+sI34Ew3tC
        CjhahnUGM6G70tmFWpZufQyFNj9Q+N5Q5iZBwxbs=
Date:   Wed, 3 Apr 2019 15:45:37 +0000
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To:     "Tobin C. Harding" <tobin@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/7] slob: Respect list_head abstraction layer
In-Reply-To: <20190402230545.2929-3-tobin@kernel.org>
Message-ID: <01000169e3e08a01-cd8427e0-3671-4263-870f-98cb4741f10d-000000@email.amazonses.com>
References: <20190402230545.2929-1-tobin@kernel.org> <20190402230545.2929-3-tobin@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.04.03-54.240.9.54
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2019, Tobin C. Harding wrote:

> Currently we reach inside the list_head.  This is a violation of the
> layer of abstraction provided by the list_head.  It makes the code
> fragile.  More importantly it makes the code wicked hard to understand.

Great.... It definitely makes it clearer. The boolean parameter is not
so nice but I have no idea how to avoid it in the brief time I spent
looking at it.

Acked-by: Christoph Lameter <cl@linux.com>

