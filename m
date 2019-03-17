Return-Path: <SRS0=5V/v=RU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED553C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 14:09:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACD12087C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Mar 2019 14:09:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SoY/jLkK";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="GZWjvgPS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbfCQOJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Mar 2019 10:09:36 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51214 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQOJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Mar 2019 10:09:35 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 50A06602F8; Sun, 17 Mar 2019 14:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552831774;
        bh=ersVU7AidXSZDjl66toAK8zV2E8W0RjZnrWqyfAc5y4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SoY/jLkKxrdpRW/eOf9apgVvzQzTaOzC/FRjaSLEYnw4OXwCCrxg/C2Xw4LHyjIQi
         ZoqkA/PGLTzs/ki2fJ72gp2Jv+zL+4JeyBzj4M100ems3f2EOz8EgRp1mveYv/XPBM
         SNfBSwqR2dt//qC9/NOd8p5tYC3oIAVM6rVD8MLA=
Received: from [192.168.1.4] (unknown [122.175.126.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gkohli@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 726AC602F8;
        Sun, 17 Mar 2019 14:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1552831773;
        bh=ersVU7AidXSZDjl66toAK8zV2E8W0RjZnrWqyfAc5y4=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GZWjvgPSbPYCf9Y7MOcRQZykSvx3KyGuFi1pwSKw9bcnriMRE+EHqAlZ46vUe3L1H
         xQa8+VCxorsczH4loNUavFFY7/i4rs5+EM1GmAw5EsXCqxg8mVRk+G2dBh6DxCN6Fh
         wGHi2DnAWgQmZn2yx8hc1ytMTajz7CxygWE+/7Ho=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 726AC602F8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH] nvmem: core: Set no-read-write provider to avoid
 userspace read/write
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, srinivas.kandagatla@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1552641937-19444-1-git-send-email-gkohli@codeaurora.org>
 <201903171227.wBkYRH1J%lkp@intel.com>
From:   Gaurav Kohli <gkohli@codeaurora.org>
Message-ID: <e9a41f2c-002e-4e56-7cd2-9f514bb82b99@codeaurora.org>
Date:   Sun, 17 Mar 2019 19:39:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <201903171227.wBkYRH1J%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh i was in wrong version, will upload new patch v2, thanks for update.

Regards

Gaurav

On 3/17/2019 9:51 AM, kbuild test robot wrote:
> Hi Gaurav,
>
> Thank you for the patch! Yet something to improve:
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v5.0 next-20190306]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Gaurav-Kohli/nvmem-core-Set-no-read-write-provider-to-avoid-userspace-read-write/20190317-105219
> config: i386-randconfig-x010-201911 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>          # save the attached .config to linux build tree
>          make ARCH=i386
>
> All errors (new ones prefixed by >>):
>
>     drivers//nvmem/core.c: In function 'nvmem_register':
>>> drivers//nvmem/core.c:662:47: error: 'np' undeclared (first use in this function); did you mean 'up'?
>       nvmem->no_read_write = of_property_read_bool(np, "no-read-write") |
>                                                    ^~
>                                                    up
>     drivers//nvmem/core.c:662:47: note: each undeclared identifier is reported only once for each function it appears in
>
> vim +662 drivers//nvmem/core.c
>
>     602	
>     603	/**
>     604	 * nvmem_register() - Register a nvmem device for given nvmem_config.
>     605	 * Also creates an binary entry in /sys/bus/nvmem/devices/dev-name/nvmem
>     606	 *
>     607	 * @config: nvmem device configuration with which nvmem device is created.
>     608	 *
>     609	 * Return: Will be an ERR_PTR() on error or a valid pointer to nvmem_device
>     610	 * on success.
>     611	 */
>     612	
>     613	struct nvmem_device *nvmem_register(const struct nvmem_config *config)
>     614	{
>     615		struct nvmem_device *nvmem;
>     616		int rval;
>     617	
>     618		if (!config->dev)
>     619			return ERR_PTR(-EINVAL);
>     620	
>     621		nvmem = kzalloc(sizeof(*nvmem), GFP_KERNEL);
>     622		if (!nvmem)
>     623			return ERR_PTR(-ENOMEM);
>     624	
>     625		rval  = ida_simple_get(&nvmem_ida, 0, 0, GFP_KERNEL);
>     626		if (rval < 0) {
>     627			kfree(nvmem);
>     628			return ERR_PTR(rval);
>     629		}
>     630	
>     631		kref_init(&nvmem->refcnt);
>     632		INIT_LIST_HEAD(&nvmem->cells);
>     633	
>     634		nvmem->id = rval;
>     635		nvmem->owner = config->owner;
>     636		if (!nvmem->owner && config->dev->driver)
>     637			nvmem->owner = config->dev->driver->owner;
>     638		nvmem->stride = config->stride ?: 1;
>     639		nvmem->word_size = config->word_size ?: 1;
>     640		nvmem->size = config->size;
>     641		nvmem->dev.type = &nvmem_provider_type;
>     642		nvmem->dev.bus = &nvmem_bus_type;
>     643		nvmem->dev.parent = config->dev;
>     644		nvmem->priv = config->priv;
>     645		nvmem->type = config->type;
>     646		nvmem->reg_read = config->reg_read;
>     647		nvmem->reg_write = config->reg_write;
>     648		if (!config->no_of_node)
>     649			nvmem->dev.of_node = config->dev->of_node;
>     650	
>     651		if (config->id == -1 && config->name) {
>     652			dev_set_name(&nvmem->dev, "%s", config->name);
>     653		} else {
>     654			dev_set_name(&nvmem->dev, "%s%d",
>     655				     config->name ? : "nvmem",
>     656				     config->name ? config->id : nvmem->id);
>     657		}
>     658	
>     659		nvmem->read_only = device_property_present(config->dev, "read-only") ||
>     660				   config->read_only || !nvmem->reg_write;
>     661	
>   > 662		nvmem->no_read_write = of_property_read_bool(np, "no-read-write") |
>     663				   config->read_only;
>     664		if (config->root_only)
>     665			nvmem->dev.groups = nvmem->read_only ?
>     666				nvmem_ro_root_dev_groups :
>     667				nvmem_rw_root_dev_groups;
>     668		else
>     669			nvmem->dev.groups = nvmem->read_only ?
>     670				nvmem_ro_dev_groups :
>     671				nvmem_rw_dev_groups;
>     672	
>     673		device_initialize(&nvmem->dev);
>     674	
>     675		dev_dbg(&nvmem->dev, "Registering nvmem device %s\n", config->name);
>     676	
>     677		rval = device_add(&nvmem->dev);
>     678		if (rval)
>     679			goto err_put_device;
>     680	
>     681		if (config->compat) {
>     682			rval = nvmem_setup_compat(nvmem, config);
>     683			if (rval)
>     684				goto err_device_del;
>     685		}
>     686	
>     687		if (config->cells) {
>     688			rval = nvmem_add_cells(nvmem, config->cells, config->ncells);
>     689			if (rval)
>     690				goto err_teardown_compat;
>     691		}
>     692	
>     693		rval = nvmem_add_cells_from_table(nvmem);
>     694		if (rval)
>     695			goto err_remove_cells;
>     696	
>     697		rval = nvmem_add_cells_from_of(nvmem);
>     698		if (rval)
>     699			goto err_remove_cells;
>     700	
>     701		blocking_notifier_call_chain(&nvmem_notifier, NVMEM_ADD, nvmem);
>     702	
>     703		return nvmem;
>     704	
>     705	err_remove_cells:
>     706		nvmem_device_remove_all_cells(nvmem);
>     707	err_teardown_compat:
>     708		if (config->compat)
>     709			device_remove_bin_file(nvmem->base_dev, &nvmem->eeprom);
>     710	err_device_del:
>     711		device_del(&nvmem->dev);
>     712	err_put_device:
>     713		put_device(&nvmem->dev);
>     714	
>     715		return ERR_PTR(rval);
>     716	}
>     717	EXPORT_SYMBOL_GPL(nvmem_register);
>     718	
>
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Center
> https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

