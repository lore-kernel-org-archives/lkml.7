Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13734C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:05:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C11062075C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:05:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="UY5G4bBJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfCMTFk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:05:40 -0400
Received: from a9-30.smtp-out.amazonses.com ([54.240.9.30]:34694 "EHLO
        a9-30.smtp-out.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726255AbfCMTFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=6gbrjpgwjskckoa6a5zn6fwqkn67xbtw; d=amazonses.com; t=1552503938;
        h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type:Feedback-ID;
        bh=4v128Tp+ktDAhV/qENqEBuzjLJBLhHo3lzR/qUMTRlo=;
        b=UY5G4bBJ5a1OOLzjRTf68GTQgR3YKY6fvzHsJl3y40wsUKdoW6BWuHJnkDt3NiQ7
        BlghG5Au0apKXSJegJmQl5/J+V9QDaa1s3kkh+yxbi6u+8U5Cmd7wtSpkmAjpyX1kOX
        Z4HZYih7uWbgxYSe8KgWjNehi0jPgOHnQMPxwq7c=
Date:   Wed, 13 Mar 2019 19:05:38 +0000
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
Subject: Re: [PATCH v2 5/5] mm: Remove stale comment from page struct
In-Reply-To: <20190313052030.13392-6-tobin@kernel.org>
Message-ID: <0100016978721dc4-11bbfcdd-3af7-469f-a8ac-d7730edc8da6-000000@email.amazonses.com>
References: <20190313052030.13392-1-tobin@kernel.org> <20190313052030.13392-6-tobin@kernel.org>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-SES-Outgoing: 2019.03.13-54.240.9.30
Feedback-ID: 1.us-east-1.fQZZZ0Xtj2+TD7V5apTT/NrT6QKuPgzCT/IC7XYgDKI=:AmazonSES
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Acked-by: Christoph Lameter <cl@linux.com>


