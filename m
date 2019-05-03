Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDCBC43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:33:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0525C2075E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 16:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556901204;
	bh=O/xEJw24VT9Hb4jjpu49qih6nck5dQTHztbx3nttuQQ=;
	h=In-Reply-To:References:To:Cc:From:Subject:Date:List-ID:From;
	b=rFVUa0zKcoAGtkyi9RejB1DkCixDzHJwR/yIexbYRcdMyzyjhA23R8EdBb4qR4rgP
	 Bve6XRsvmPtzwrvmJSHz/qtFW6XnzSR+VS0zbWMOjTqU9gxbagodvw+oaDfwAemwUd
	 Px0cq0LaoKFgvr5kh5Ey9TuprYm6GRdE1G9sNmdg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbfECQdW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 12:33:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:33656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726585AbfECQdW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 12:33:22 -0400
Received: from localhost (unknown [104.132.0.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D644F20651;
        Fri,  3 May 2019 16:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556901201;
        bh=O/xEJw24VT9Hb4jjpu49qih6nck5dQTHztbx3nttuQQ=;
        h=In-Reply-To:References:To:Cc:From:Subject:Date:From;
        b=lF3lhaV+ZwRGoMCbf2EH3F6q1J7furZeR5G0vyXJt/zrXk8OqY+TKfc03W9cWapWG
         QUihVJMlBpOMBwuRhQO3X5Hc/qSgv5n9QVAocTKUXvwSABkC42ETKcwWCFWAT82Qzl
         Lq09bK2Bb4HoycPz5MoEYTHIgnFZz4+onWOlOXKk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <c1d3fd4db13d999a3ba57f5bbc1924862d824f61.1556881728.git.leonard.crestez@nxp.com>
References: <cover.1556881728.git.leonard.crestez@nxp.com> <c1d3fd4db13d999a3ba57f5bbc1924862d824f61.1556881728.git.leonard.crestez@nxp.com>
To:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michael Turquette <mturquette@baylibre.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/2] scripts/gdb: Cleanup error handling in list helpers
Message-ID: <155690120115.200842.4461891246222331678@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Fri, 03 May 2019 09:33:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Leonard Crestez (2019-05-03 04:19:31)
> An incorrect argument to list_for_each is an internal error in gdb
> scripts so a TypeError should be raised. The gdb.GdbError exception type
> is intended for user errors such as incorrect invocation.
>=20
> Drop the type assertion in list_for_each_entry because list_for_each isn't
> going to suddenly yield something else.
>=20
> Applies to both list and hlist

This should be done to other "type errors" in the gdb scripts too.

>=20
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
> ---

Either way,

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

