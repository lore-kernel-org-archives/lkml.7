Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB79C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 360D2208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfDAQCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:02:15 -0400
Received: from anholt.net ([50.246.234.109]:45148 "EHLO anholt.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726988AbfDAQCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:02:15 -0400
Received: from localhost (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 23FB510A278C;
        Mon,  1 Apr 2019 09:02:14 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at anholt.net
Received: from anholt.net ([127.0.0.1])
        by localhost (kingsolver.anholt.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id wBRyWKkkxT8e; Mon,  1 Apr 2019 09:02:10 -0700 (PDT)
Received: from eliezer.anholt.net (localhost [127.0.0.1])
        by anholt.net (Postfix) with ESMTP id 9D68B10A2230;
        Mon,  1 Apr 2019 09:02:10 -0700 (PDT)
Received: by eliezer.anholt.net (Postfix, from userid 1000)
        id 370C62FE2F72; Mon,  1 Apr 2019 09:02:10 -0700 (PDT)
From:   Eric Anholt <eric@anholt.net>
To:     Rob Herring <robh@kernel.org>, dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Lyude Paul <lyude@redhat.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "Marty E . Plummer" <hanetzer@startmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v2 3/3] drm/panfrost: Add initial panfrost driver
In-Reply-To: <20190401074730.12241-4-robh@kernel.org>
References: <20190401074730.12241-1-robh@kernel.org> <20190401074730.12241-4-robh@kernel.org>
User-Agent: Notmuch/0.22.2+1~gb0bcfaa (http://notmuchmail.org) Emacs/25.2.2 (x86_64-pc-linux-gnu)
Date:   Mon, 01 Apr 2019 09:02:09 -0700
Message-ID: <87zhp9zpby.fsf@anholt.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha512; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Rob Herring <robh@kernel.org> writes:

> This adds the initial driver for panfrost which supports Arm Mali
> Midgard and Bifrost family of GPUs. Currently, only the T860 and
> T760 Midgard GPUs have been tested.
>
> v2:
> - Add GPU reset on job hangs (Tomeu)
> - Add RuntimePM and devfreq support (Tomeu)
> - Fix T760 support (Tomeu)
> - Add a TODO file (Rob, Tomeu)
> - Support multiple in fences (Tomeu)
> - Drop support for shared fences (Tomeu)
> - Fill in MMU de-init (Rob)
> - Move register definitions back to single header (Rob)
> - Clean-up hardcoded job submit todos (Rob)
> - Implement feature setup based on features/issues (Rob)
> - Add remaining Midgard DT compatible strings (Rob)
>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <maxime.ripard@bootlin.com>
> Cc: Sean Paul <sean@poorly.run>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Eric Anholt <eric@anholt.net>
> Signed-off-by: Marty E. Plummer <hanetzer@startmail.com>
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Neil, I've kept your reset support separate for now. Let me know if you
> prefer me to squash it or keep it separate.


> +static void panfrost_job_hw_submit(struct panfrost_job *job, int js)
> +{
> +	struct panfrost_device *pfdev =3D job->pfdev;
> +	unsigned long flags;
> +	u32 cfg;
> +	u64 jc_head =3D job->jc;
> +	int ret;
> +
> +	panfrost_devfreq_update_utilization(pfdev, js, false);
> +
> +	ret =3D pm_runtime_get_sync(pfdev->dev);
> +	if (ret < 0)
> +		return;
> +
> +	if (WARN_ON(job_read(pfdev, JS_COMMAND_NEXT(js))))
> +		goto end;
> +
> +	spin_lock_irqsave(&pfdev->hwaccess_lock, flags);
> +
> +	job_write(pfdev, JS_HEAD_NEXT_LO(js), jc_head & 0xFFFFFFFF);
> +	job_write(pfdev, JS_HEAD_NEXT_HI(js), jc_head >> 32);
> +
> +	panfrost_job_write_affinity(pfdev, job->requirements, js);
> +
> +	/* start MMU, medium priority, cache clean/flush on end, clean/flush on
> +	 * start */
> +	// TODO: different address spaces
> +	cfg =3D JS_CONFIG_THREAD_PRI(8) |
> +		JS_CONFIG_START_FLUSH_CLEAN_INVALIDATE |
> +		JS_CONFIG_END_FLUSH_CLEAN_INVALIDATE;
> +
> +	if (panfrost_has_hw_feature(pfdev, HW_FEATURE_FLUSH_REDUCTION))
> +		cfg |=3D JS_CONFIG_ENABLE_FLUSH_REDUCTION;
> +
> +	if (panfrost_has_hw_issue(pfdev, HW_ISSUE_10649))
> +		cfg |=3D JS_CONFIG_START_MMU;
> +
> +	job_write(pfdev, JS_CONFIG_NEXT(js), cfg);
> +
> +	if (panfrost_has_hw_feature(pfdev, HW_FEATURE_FLUSH_REDUCTION))
> +		job_write(pfdev, JS_FLUSH_ID_NEXT(js), job->flush_id);
> +
> +	/* GO ! */
> +	dev_dbg(pfdev->dev, "JS: Submitting atom %p to js[%d] with head=3D0x%ll=
x",
> +				job, js, jc_head);
> +
> +	job_write(pfdev, JS_COMMAND_NEXT(js), JS_COMMAND_START);
> +
> +	spin_unlock_irqrestore(&pfdev->hwaccess_lock, flags);
> +
> +end:
> +	pm_runtime_mark_last_busy(pfdev->dev);
> +	pm_runtime_put_autosuspend(pfdev->dev);
> +}
> +
> +static void panfrost_acquire_object_fences(struct drm_gem_object **bos,
> +					   int bo_count,
> +					   struct dma_fence **implicit_fences)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < bo_count; i++)
> +		implicit_fences[i] =3D reservation_object_get_excl_rcu(bos[i]->resv);
> +}

This is a little bit dodgy for implicit sync if the BOs are shared as
dma-bufs to some other device that distinguishes between shared vs excl
reservations.  (A distinction I think is not worth it, but it's the
interface we have).  If the other device has a read-only job, and you
submit a new job updating it, the other device may get the new contents
when it shouldn't.

However, this is a very minor bug and I don't think it should block
things.

> +int panfrost_job_push(struct panfrost_job *job)
> +{
> +	struct panfrost_device *pfdev =3D job->pfdev;
> +	int slot =3D panfrost_job_get_slot(job);
> +	struct drm_sched_entity *entity =3D &job->file_priv->sched_entity[slot];
> +	struct ww_acquire_ctx acquire_ctx;
> +	int ret =3D 0;
> +
> +	mutex_lock(&pfdev->sched_lock);
> +
> +	ret =3D drm_gem_lock_reservations(job->bos, job->bo_count,
> +					    &acquire_ctx);
> +	if (ret) {
> +		mutex_unlock(&pfdev->sched_lock);
> +		return ret;
> +	}
> +
> +	ret =3D drm_sched_job_init(&job->base, entity, NULL);
> +	if (ret) {
> +		mutex_unlock(&pfdev->sched_lock);
> +		goto unlock;
> +	}
> +
> +	job->render_done_fence =3D dma_fence_get(&job->base.s_fence->finished);
> +
> +	kref_get(&job->refcount); /* put by scheduler job completion */
> +
> +	drm_sched_entity_push_job(&job->base, entity);
> +
> +	mutex_unlock(&pfdev->sched_lock);
> +
> +	panfrost_acquire_object_fences(job->bos, job->bo_count,
> +				       job->implicit_fences);

I think your implicit fences need to be up above
drm_sched_entity_push_job(), since they might get referenced by the
scheduler any time after push_job.

> +	panfrost_attach_object_fences(job->bos, job->bo_count,
> +				      job->render_done_fence);
> +
> +unlock:
> +	drm_gem_unlock_reservations(job->bos, job->bo_count, &acquire_ctx);
> +
> +	return ret;
> +}

> +static void panfrost_job_timedout(struct drm_sched_job *sched_job)
> +{
> +	struct panfrost_job *job =3D to_panfrost_job(sched_job);
> +	struct panfrost_device *pfdev =3D job->pfdev;
> +	int js =3D panfrost_job_get_slot(job);
> +	int i;
> +
> +	/*
> +	 * If the GPU managed to complete this jobs fence, the timeout is
> +	 * spurious. Bail out.
> +	 */
> +	if (dma_fence_is_signaled(job->done_fence))
> +		return;
> +
> +	dev_err(pfdev->dev, "gpu sched timeout, js=3D%d, status=3D0x%x, head=3D=
0x%x, tail=3D0x%x, sched_job=3D%p",
> +		js,
> +		job_read(pfdev, JS_STATUS(js)),
> +		job_read(pfdev, JS_HEAD_LO(js)),
> +		job_read(pfdev, JS_TAIL_LO(js)),
> +		sched_job);
> +
> +	for (i =3D 0; i < NUM_JOB_SLOTS; i++)
> +		drm_sched_stop(&pfdev->js->queue[i].sched);
> +
> +	if(sched_job)
> +		drm_sched_increase_karma(sched_job);

whitespace

> +
> +	//panfrost_core_dump(pfdev);

Might want to go over the driver for // comments that should be removed?


> diff --git a/include/uapi/drm/panfrost_drm.h b/include/uapi/drm/panfrost_=
drm.h
> new file mode 100644
> index 000000000000..508b9621d9db
> --- /dev/null
> +++ b/include/uapi/drm/panfrost_drm.h
> @@ -0,0 +1,140 @@
> +/* SPDX-License-Identifier: MIT */
> +/*
> + * Copyright =C2=A9 2014-2018 Broadcom
> + * Copyright =C2=A9 2019 Collabora ltd.
> + */
> +#ifndef _PANFROST_DRM_H_
> +#define _PANFROST_DRM_H_
> +
> +#include "drm.h"
> +
> +#if defined(__cplusplus)
> +extern "C" {
> +#endif
> +
> +#define DRM_PANFROST_SUBMIT			0x00
> +#define DRM_PANFROST_WAIT_BO			0x01
> +#define DRM_PANFROST_CREATE_BO			0x02
> +#define DRM_PANFROST_MMAP_BO			0x03
> +#define DRM_PANFROST_GET_PARAM			0x04
> +#define DRM_PANFROST_GET_BO_OFFSET		0x05
> +
> +#define DRM_IOCTL_PANFROST_SUBMIT		DRM_IOW(DRM_COMMAND_BASE + DRM_PANFRO=
ST_SUBMIT, struct drm_panfrost_submit)
> +#define DRM_IOCTL_PANFROST_WAIT_BO		DRM_IOW(DRM_COMMAND_BASE + DRM_PANFR=
OST_WAIT_BO, struct drm_panfrost_wait_bo)
> +#define DRM_IOCTL_PANFROST_CREATE_BO		DRM_IOWR(DRM_COMMAND_BASE + DRM_PA=
NFROST_CREATE_BO, struct drm_panfrost_create_bo)
> +#define DRM_IOCTL_PANFROST_MMAP_BO		DRM_IOWR(DRM_COMMAND_BASE + DRM_PANF=
ROST_MMAP_BO, struct drm_panfrost_mmap_bo)
> +#define DRM_IOCTL_PANFROST_GET_PARAM		DRM_IOWR(DRM_COMMAND_BASE + DRM_PA=
NFROST_GET_PARAM, struct drm_panfrost_get_param)
> +#define DRM_IOCTL_PANFROST_GET_BO_OFFSET	DRM_IOWR(DRM_COMMAND_BASE + DRM=
_PANFROST_GET_BO_OFFSET, struct drm_panfrost_get_bo_offset)
> +
> +#define PANFROST_JD_REQ_FS (1 << 0)
> +/**
> + * struct drm_panfrost_submit - ioctl argument for submitting commands t=
o the 3D
> + * engine.
> + *
> + * This asks the kernel to have the GPU execute a render command list.
> + */
> +struct drm_panfrost_submit {
> +
> +	/** Address to GPU mapping of job descriptor */
> +	__u64 jc;
> +
> +	/** An optional array of sync objects to wait on before starting this j=
ob. */
> +	__u64 in_syncs;
> +
> +	/** Number of sync objects to wait on before starting this job. */
> +	__u32 in_sync_count;
> +
> +	/** An optional sync object to place the completion fence in. */
> +	__u32 out_sync;
> +
> +	/** Pointer to a u32 array of the BOs that are referenced by the job. */
> +	__u64 bo_handles;
> +
> +	/** Number of BO handles passed in (size is that times 4). */
> +	__u32 bo_handle_count;
> +
> +	/** A combination of PANFROST_JD_REQ_* */
> +	__u32 requirements;
> +};
> +
> +/**
> + * struct drm_panfrost_wait_bo - ioctl argument for waiting for
> + * completion of the last DRM_PANFROST_SUBMIT_CL on a BO.
> + *
> + * This is useful for cases where multiple processes might be
> + * rendering to a BO and you want to wait for all rendering to be
> + * completed.
> + */
> +struct drm_panfrost_wait_bo {
> +	__u32 handle;
> +	__u32 pad;
> +	__s64 timeout_ns;	/* absolute */
> +};
> +
> +/**
> + * struct drm_panfrost_create_bo - ioctl argument for creating Panfrost =
BOs.
> + *
> + * There are currently no values for the flags argument, but it may be
> + * used in a future extension.
> + */
> +struct drm_panfrost_create_bo {
> +	__u32 size;
> +	__u32 flags;
> +	/** Returned GEM handle for the BO. */
> +	__u32 handle;
> +	/**
> +	 * Returned offset for the BO in the GPU address space.  This offset
> +	 * is private to the DRM fd and is valid for the lifetime of the GEM
> +	 * handle.
> +	 *
> +	 * This offset value will always be nonzero, since various HW
> +	 * units treat 0 specially.
> +	 */
> +	__u64 offset;
> +};

I think you've got a u64 alignment issue here that needs explicit
padding so that you don't end up needing 32-vs-64 ioctl wrappers..

This and the implicit fence acquisition race are the two things I think
need fixing, then you can add:

Reviewed-by: Eric Anholt <eric@anholt.net>

The rest is just suggestions for later.

> +
> +/**
> + * struct drm_panfrost_mmap_bo - ioctl argument for mapping Panfrost BOs.
> + *
> + * This doesn't actually perform an mmap.  Instead, it returns the
> + * offset you need to use in an mmap on the DRM device node.  This
> + * means that tools like valgrind end up knowing about the mapped
> + * memory.
> + *
> + * There are currently no values for the flags argument, but it may be
> + * used in a future extension.
> + */
> +struct drm_panfrost_mmap_bo {
> +	/** Handle for the object being mapped. */
> +	__u32 handle;
> +	__u32 flags;
> +	/** offset into the drm node to use for subsequent mmap call. */
> +	__u64 offset;
> +};
> +
> +enum drm_panfrost_param {
> +	DRM_PANFROST_PARAM_GPU_ID,
> +};
> +
> +struct drm_panfrost_get_param {
> +	__u32 param;
> +	__u32 pad;
> +	__u64 value;
> +};
> +
> +/**
> + * Returns the offset for the BO in the GPU address space for this DRM f=
d.
> + * This is the same value returned by drm_panfrost_create_bo, if that wa=
s called
> + * from this DRM fd.
> + */
> +struct drm_panfrost_get_bo_offset {
> +	__u32 handle;
> +	__u32 pad;
> +	__u64 offset;
> +};
> +
> +#if defined(__cplusplus)
> +}
> +#endif
> +
> +#endif /* _PANFROST_DRM_H_ */
> --
> 2.19.1

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE/JuuFDWp9/ZkuCBXtdYpNtH8nugFAlyiNgEACgkQtdYpNtH8
nuhFyRAAhgTD2s3f21NPiQdmQCytCzfDoaM07Ag4q6OlxjojRi+c8crgOzwTSdZ2
53HPjDglQaaMYCfcG0/C1JxcLnH9BkmDh1aCJH4bBxWmOTt9G1GiidsIwe1wvshV
Jr351aIzScqNLnrP1H53zwvF0DDqbmRtgT4z4IUFSKywUlJO0H09+BYAuOFbbapY
fAntQlcEQzJyrlQR4kuJPr7C3vlfP36wONDsV5enuMYrYpZWZUjnEyiL4Le9GF7Q
Qtzwmqy6E5pTGvKGC37sjnxn7HiWzB14dVXNBuBV6NDlECdKE0PbmetQAOftY3MY
PLwVLqRp/Zl/LG8DhakOszlvnklh+mXnQHRYgqVdblQeC/P2J/It/kKlcssMRr/P
p+gceoGitBXegaY1v+w8itAhVlvuYiRBLtpsVKiQ72+NvdPPlV6ypOr/x+emRZ2v
zAmKFMZTQXFh3SFHh7d9RQBGqDF0hD+2PLIR2PEqsq1zg8WUllStJ7oylVJh5oA7
2hxuD2YJx3iylEsWkOSn1SQYcrqJPqiTvegfdK3KfSbxoH3xROPC7YdzmWDjfHXW
ksToXgeokPP0auR1CsjjhsznhYTNL67mDymWbqWtAIo0YGu0+0ZTsRnve/3aEIiF
9eFNACK5v15z+jDrGEg5CMRteJKs2AAWV0cpX+08N5cGsc6UcRU=
=B8sg
-----END PGP SIGNATURE-----
--=-=-=--
