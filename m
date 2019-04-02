Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD305C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:22:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A979820857
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 10:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554200562;
	bh=uE4fVXashDaMVo05Fhcbbq7j1fOaLOo6nhEi+7RiYos=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:List-ID:From;
	b=cqnSagdv3jTB6U6yrF5XCZAbWZBy5/3t3fK+dKqqpifIyvx7nbj5vtT5YnusGb8bY
	 0ERIKTSIVKeYIjPEdXfrHxvykhU5l4+RGmC7ij2tGLvWdjYbEq7bvNAuMpR0A7c+12
	 h+0bCZ+vOSjhfaXDSeNEECCIuboYESnQnCzNN8Xk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730204AbfDBKWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 06:22:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:36014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726705AbfDBKWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 06:22:40 -0400
Received: from pobox.suse.cz (prg-ext-pat.suse.com [213.151.95.130])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88DC52082C;
        Tue,  2 Apr 2019 10:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554200560;
        bh=uE4fVXashDaMVo05Fhcbbq7j1fOaLOo6nhEi+7RiYos=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=torp+Ys+hXAiNdUg26vf9LnDooouPiOgFdDzIFiEYcdrtjuyLfKPzVIROv7IagcSb
         K3fO5LMUEvTR2loy9eHo8MdG1LKG/IGeQxM2giO7x/8glU1tGQBk4bT9m2smB6Gh1R
         6aKjgyDqflvQ411xWX/toAFaa9yp1bvoVhI5lJ6E=
Date:   Tue, 2 Apr 2019 12:22:22 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Kimberly Brown <kimbrownkd@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/8] livepatch: Replace klp_ktype_patch's default_attrs
 with groups
In-Reply-To: <1571eb59b1d523aac81d524ae20a56cf378ef9c4.1554151487.git.kimbrownkd@gmail.com>
Message-ID: <nycvar.YFH.7.76.1904021219391.9803@cbobk.fhfr.pm>
References: <20190322201440.GA30814@ubu-Virtual-Machine> <cover.1554151487.git.kimbrownkd@gmail.com> <1571eb59b1d523aac81d524ae20a56cf378ef9c4.1554151487.git.kimbrownkd@gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2019, Kimberly Brown wrote:

> The kobj_type default_attrs field is being replaced by the
> default_groups field. Replace klp_ktype_patch's default_attrs field
> with default_groups and use the ATTRIBUTE_GROUPS macro to create
> klp_patch_groups.
> 
> This patch was tested by loading the livepatch-sample module and
> verifying that the sysfs files for the attributes in the default groups
> were created.
> 
> Signed-off-by: Kimberly Brown <kimbrownkd@gmail.com>

Acked-by: Jiri Kosina <jkosina@suse.cz>

Greg, feel free to route this one through your tree.

-- 
Jiri Kosina
SUSE Labs

